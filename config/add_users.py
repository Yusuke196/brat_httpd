import argparse
import json
import re


def main(args):
    with open(args.config, 'r') as file:
        config = file.read()

    user_json = json.load(open(args.json, 'r'))

    user_str = '%s,' % ',\n'.join(
        ["'{}': '{}'".format(u, p) for u, p in user_json.items()]
    )

    new_config = re.sub(
        'USER_PASSWORD = \{([^}]+)\}',
        'USER_PASSWORD = {\g<1>%s\n}' % user_str,
        config,
    )

    with open(args.config, 'w') as file:
        file.write(new_config)


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('config')
    parser.add_argument('json')
    args = parser.parse_args()
    return args


if __name__ == '__main__':
    args = parse_args()
    main(args)