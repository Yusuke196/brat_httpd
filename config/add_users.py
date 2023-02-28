import argparse
import json
import os
import re


def main(args):
    user_json = json.load(open(args.user_file, 'r'))[args.site_suffix]
    if len(user_json) == 0:
        return

    if args.site_suffix != '':
        dir_name = 'brat-' + args.site_suffix
    else:
        dir_name = 'brat'
    with open(os.path.join(dir_name, args.config), 'r') as file:
        config = file.read()

    user_str = '%s,' % ',\n'.join(
        ["'{}': '{}'".format(u, p) for u, p in user_json.items()]
    )
    new_config = re.sub(
        'USER_PASSWORD = \{([^}]+)\}',
        'USER_PASSWORD = {\g<1>%s\n}' % user_str,
        config,
    )

    with open(os.path.join(dir_name, args.config), 'w') as file:
        file.write(new_config)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('config')
    parser.add_argument('user_file')
    parser.add_argument('--site_suffix', default='')
    args = parser.parse_args()
    return args


if __name__ == '__main__':
    args = parse_args()
    main(args)
