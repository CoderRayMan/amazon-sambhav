import random
import math
from collections import defaultdict


class BalancedKMeans:
    def __init__(self, coordinates, num_clusters, max_iterations=100):
        """
        Initialize the BalancedKMeans clustering.
        :param coordinates: List of (latitude, longitude) tuples.
        :param num_clusters: Number of clusters.
        :param max_iterations: Maximum number of iterations for k-means clustering.
        """
        self.coordinates = coordinates
        self.num_clusters = num_clusters
        self.max_iterations = max_iterations

    @staticmethod
    def haversine_distance(coord1, coord2):
        """
        Calculate the Haversine distance between two latitude-longitude points.
        :param coord1: Tuple (lat1, lon1) in degrees.
        :param coord2: Tuple (lat2, lon2) in degrees.
        :return: Distance in kilometers.
        """
        R = 6371  # Earth's radius in kilometers
        lat1, lon1 = math.radians(coord1[0]), math.radians(coord1[1])
        lat2, lon2 = math.radians(coord2[0]), math.radians(coord2[1])

        dlat = lat2 - lat1
        dlon = lon2 - lon1

        a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
        return R * c

    def calculate_centroids(self, clusters):
        """
        Calculate new centroids as the mean of points in each cluster.
        :param clusters: List of clusters, where each cluster is a list of point indices.
        :return: List of new centroids as (latitude, longitude).
        """
        centroids = []
        for cluster in clusters:
            if len(cluster) == 0:
                # Handle empty cluster by assigning a random point as its centroid
                centroids.append(random.choice(self.coordinates))
            else:
                # Calculate the mean latitude and longitude
                cluster_points = [self.coordinates[idx] for idx in cluster]
                lat_mean = sum(point[0] for point in cluster_points) / len(cluster_points)
                lon_mean = sum(point[1] for point in cluster_points) / len(cluster_points)
                centroids.append((lat_mean, lon_mean))
        return centroids

    def assign_clusters(self, centroids):
        """
        Assign each point to the nearest centroid.
        :param centroids: Current centroids as (latitude, longitude).
        :return: A list of clusters, where each cluster is a list of point indices.
        """
        clusters = defaultdict(list)
        for idx, point in enumerate(self.coordinates):
            distances = [self.haversine_distance(point, centroid) for centroid in centroids]
            nearest_centroid = distances.index(min(distances))
            clusters[nearest_centroid].append(idx)
        return [clusters[i] for i in range(self.num_clusters)]

    def balance_clusters(self, clusters):
        """
        Ensure clusters are balanced by redistributing points.
        :param clusters: List of clusters, where each cluster is a list of point indices.
        :return: Balanced list of clusters.
        """
        while True:
            sizes = [len(cluster) for cluster in clusters]
            max_size = max(sizes)
            min_size = min(sizes)
            if max_size - min_size <= 1:
                break

            max_cluster_idx = sizes.index(max_size)
            min_cluster_idx = sizes.index(min_size)

            # Move a point from the largest cluster to the smallest
            point_to_move = clusters[max_cluster_idx].pop()
            clusters[min_cluster_idx].append(point_to_move)
        return clusters

    def balanced_kmeans(self):
        """
        Perform balanced k-means clustering.
        :return: A list of balanced clusters, where each cluster is a list of point indices.
        """
        # Initialize centroids randomly from the given coordinates
        centroids = random.sample(self.coordinates, self.num_clusters)

        for _ in range(self.max_iterations):
            # Assign points to the nearest centroid
            clusters = self.assign_clusters(centroids)
            # Recalculate centroids
            new_centroids = self.calculate_centroids(clusters)
            # Check for convergence
            if new_centroids == centroids:
                break
            centroids = new_centroids

        # Balance the clusters
        return self.balance_clusters(clusters)


# Usage Example
if __name__ == "__main__":
    coordinates = [
        (12.971598, 77.594566),  # Bangalore
        (28.704060, 77.102493),  # Delhi
        (19.076090, 72.877426),  # Mumbai
        (13.082680, 80.270721),  # Chennai
        (22.572645, 88.363892),  # Kolkata
        (23.022505, 72.571362),  # Ahmedabad
    ]
    num_clusters = 2

    kmeans = BalancedKMeans(coordinates, num_clusters)
    clusters = kmeans.balanced_kmeans()
    print("Clusters:", clusters)
