import numpy as np
import random


class AntColonyOptimization:
    def __init__(self, distance_matrix, num_ants, num_iterations, alpha, beta, evaporation_rate, q):
        self.distance_matrix = distance_matrix
        self.num_ants = num_ants
        self.num_iterations = num_iterations
        self.alpha = alpha  # Importance of pheromone
        self.beta = beta  # Importance of distance
        self.evaporation_rate = evaporation_rate
        self.q = q  # Constant for pheromone update
        self.num_nodes = len(distance_matrix)
        self.pheromone = np.ones((self.num_nodes, self.num_nodes))  # Initial pheromone values

    def run(self):
        best_route = None
        best_distance = float('inf')

        for _ in range(self.num_iterations):
            all_routes = []
            all_distances = []

            for _ in range(self.num_ants):
                route, distance = self.construct_solution()
                all_routes.append(route)
                all_distances.append(distance)

                if distance < best_distance:
                    best_route = route
                    best_distance = distance

            self.update_pheromone(all_routes, all_distances)

        return best_route, best_distance

    def construct_solution(self):
        unvisited = list(range(self.num_nodes))
        current_node = random.choice(unvisited)
        route = [current_node]
        unvisited.remove(current_node)
        total_distance = 0

        while unvisited:
            probabilities = self.calculate_probabilities(current_node, unvisited)
            next_node = random.choices(unvisited, weights=probabilities, k=1)[0]
            route.append(next_node)
            total_distance += self.distance_matrix[current_node][next_node]
            unvisited.remove(next_node)
            current_node = next_node

        # Add distance to return to start
        total_distance += self.distance_matrix[current_node][route[0]]
        return route, total_distance

    def calculate_probabilities(self, current_node, unvisited):
        pheromones = np.array([self.pheromone[current_node][j] for j in unvisited])
        distances = np.array([self.distance_matrix[current_node][j] for j in unvisited])
        desirability = (pheromones ** self.alpha) * ((1 / distances) ** self.beta)
        probabilities = desirability / desirability.sum()
        return probabilities

    def update_pheromone(self, all_routes, all_distances):
        self.pheromone *= (1 - self.evaporation_rate)  # Evaporate pheromones

        for route, distance in zip(all_routes, all_distances):
            for i in range(len(route) - 1):
                self.pheromone[route[i]][route[i + 1]] += self.q / distance
            # Update pheromone for returning to the start
            self.pheromone[route[-1]][route[0]] += self.q / distance