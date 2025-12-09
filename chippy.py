import networkx as nx

#Load file and create nodes
file = []
sprites = nx.DiGraph()
with open("imgout.txt") as f:
    for i, line in enumerate(f):
        sprite = [int(i,2) for i in line.split(',')]
#        while sprite and sprite[0] == 0:
#            sprite.pop(0)
#        while sprite and sprite[-1] == 0:
#            sprite.pop()
        file.append(sprite)
        sprites.add_node(i)

#Find sequences:
        
print("Sequences:")
for i in range(sprites.number_of_nodes()):
    for j in range(sprites.number_of_nodes()):
        if j == i:
                continue
        for dist in range(1, 15):
            if (file[i][(dist-15):] == file[j][:(15-dist)]):
                print(str(i) + ', ' + str(j) + ', ' + str(dist))
                sprites.add_edge(i, j, weight=dist)
                break
        if not sprites.has_edge(i, j):
            sprites.add_edge(i, j, weight=1000000000)

#Export GML
nx.write_gml(sprites, "sprites.gml")

print("solving")
out = nx.approximation.greedy_tsp(sprites)
print(out)
