import click

@click.command()
@click.option('--train_file','-t', default=None, help='Number of greetings.')

def hello(train_file):
    print(train_file)

if __name__ == '__main__':
    hello()