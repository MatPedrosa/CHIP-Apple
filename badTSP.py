import networkx as nx

print("loading")
sprites = nx.read_gml("sprites.gml")
print("done")

path = [0]

candidates = list(sprites.out_edges(list(sprites.nodes)[path[-1]]))
candidates.sort(key=lambda edge: sprites.edges[edge]['weight'])
for i in candidates:
    if not candidates[i] in path:
        path.append(candidates[i])
        print(candidates[i)
        break
