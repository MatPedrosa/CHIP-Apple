import networkx as nx

print("loading")
sprites = nx.read_gml("sprites.gml")

print("completing graph")
for u in list(sprites.nodes):
    for v in list(sprites.nodes):
        if u == v:
            continue
        if not sprites.has_edge(u, v):
            sprites.add_edge(u, v, weight=1000000)

print("solving")
out = nx.approximation.greedy_tsp(sprites)

print("done")
