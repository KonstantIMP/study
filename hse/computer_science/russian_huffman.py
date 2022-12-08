def fixed_str(a, n):
    return '0' * max(0, n - len(str(a))) + str(a)


def write_letter_card(card):
    global mapping
    current_num = len(mapping.keys()) + 1
    print(f'card l{fixed_str(current_num, 2)} [')
    print(f'    {card[1]}')
    print(f'    ----')
    print(f'    0.{fixed_str(card[0], 5)}')
    print(f']')
    print()
    mapping[card[1]] = current_num


data = """
    О 0.10983 М 0.03203 Й 0.01208
    Е 0.08483 Д 0.02977 Х 0.00966
    А 0.07998 П 0.02804 Ж 0.00940
    И 0.07367 У 0.02615 Ш 0.00718
    Н 0.06700 Я 0.02001 Ю 0.00639
    Т 0.06318 Ы 0.01898 Ц 0.00486
    С 0.05473 Ь 0.01735 Щ 0.00361
    Р 0.04746 Г 0.01687 Э 0.00331
    В 0.04533 З 0.01641 Ф 0.00267
    Л 0.04343 Б 0.01592 Ъ 0.00037
    К 0.03486 Ч 0.01450 Ё 0.00013
""".split()

letters = []

for i in range(len(data) // 2):
    letters.append((
        int(data[i * 2 + 1][2:]), data[i * 2]
    ))

global mapping
mapping = dict()

while len(letters) > 1:
    letters.sort()

    f, s = letters[0], letters[1]
    new_card = (s[0] + f[0], s[1] + f[1])

    for el in [f, s, new_card]:
        if el[1] not in mapping:
            write_letter_card(el)

    print(f'l{fixed_str(mapping[f[1]], 2)} -[hidden]down- l{fixed_str(mapping[s[1]], 2)}')
    print(f'l{fixed_str(mapping[f[1]], 2)} -right-> l{fixed_str(mapping[new_card[1]], 2)} : 0')
    print(f'l{fixed_str(mapping[s[1]], 2)} -right-> l{fixed_str(mapping[new_card[1]], 2)} : 1')
    print()

    letters = [new_card] + letters[2::]

