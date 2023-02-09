def main():
    with open('tools.conf') as file:
        res = file.read().replace(
            'Sentences	splitter:regex', 'Sentences	splitter:newline'
        )
    with open('tools.conf', 'w') as file:
        file.write(res)

if __name__ == '__main__':
    main()
