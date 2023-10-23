def ro(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b [1])


def check(roads, distances, start, finish):
    if start[0] == finish[0] and start[1] == finish[1]:
        return
    c = distances[start]

    checks = set()
    if start not in roads:
        return

    for p in roads[start]:
        if c + 1 < distances[p]:
            distances[p] = c + 1
            checks.add(p)

    for p in checks:
        check(roads, distances, p, finish)


n = int(input())

reader = lambda: tuple(map(int, input().split()))
points = [reader() for _ in range(n)]

k = int(input())
start, finish = map(lambda x: points[int(x) - 1], input().split())


roads = dict()
distances = dict()


for i in range(n):
    for j in range(i + 1, n):
        a, b = points[i], points[j]
        if ro(a, b) <= k:
            if a not in roads:
                roads[a] = set()
            if b not in roads:
                roads[b] = set()
            roads[a].add(b)
            roads[b].add(a)

    distances[points[i]] = float('inf')

distances[start] = 0
check(roads, distances, start, finish)
print(distances[finish] if distances[finish] != float('inf') else -1)
