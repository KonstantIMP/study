from itertools import product
from math import ceil, log2

import typing as tp

def build_info(points: tp.Set[int], n: int = 0) -> tp.List[str]:
    var_n = ceil(log2(max(points))) if n == 0 else n
    alphabet = 'abcdefghijklmnopqrstuvwxyz'

    d, k = [], []

    counter = 0

    table = f"""
    \\begin{{table}}[H]
        \\centering
        \\begin{{tabular}}{{{'| c ' * (var_n + 1)}|}}
            \\hline
            {
                ''.join(
                    map(
                        lambda x: '$' + alphabet[x] + '$ & ',
                        list(range(var_n))
                    )
                )
            }$F$ \\\\
            \\hline
    """

    for line in product(range(2), repeat=var_n):
        table += f"""\t\t\t{
            ' & '.join(map(str, line))
        } & {
            1 if counter in points else 0
        } \\\\\n"""

        temp = ''

        if counter in points:
            for i in range(len(line)):
                if line[i] == 0:
                    temp += f'\\overline{{{alphabet[i]}}}'
                else: temp += f'{alphabet[i]}'
            d.append(temp)
        else:
            for i in range(len(line)):
                if line[i] == 0: temp += f'{alphabet[i]}'
                else:
                    temp += f'\\overline{{{alphabet[i]}}}'
                if i + 1 != len(line): temp += ' + '
            k.append(temp)

        counter += 1

    table += f"""
            \\hline
        \\end{{tabular}}
        \\caption{{there should be caption}}
    \\end{{table}}
    """

    return [table, ' + '.join(d), '(' + ')('.join(k) + ')']


def main():
    points = set(sorted(list(
        map(int, input().strip().split())
    )))

    print(f'Your points is: [{", ".join(map(str, points))}]')

    info = build_info(points)
    
    print('Table for given points')
    print(info[0])

    print('Disjunctive normal form')
    print()
    print(info[1])

    print('Conjunctive normal form')
    print()
    print(info[2])


if __name__ == '__main__':
    main()

