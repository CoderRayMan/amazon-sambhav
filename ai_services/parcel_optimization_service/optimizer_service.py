import pandas as pd
import numpy as np
from datetime import datetime
from math import radians, sin, cos, sqrt, atan2
from aco import AntColonyOptimization
from create_clusters import BalancedKMeans
from data_operations import FetchData, WriteData
from interface.IRouteOptimize import IRouteOptimize


class OptimizeRoutes(IRouteOptimize):

    def __init__(self):
        self.orders_df = None
        self.w_id = None
        self.zip_df = None

    @staticmethod
    def haversine(lat1, lon1, lat2, lon2):
        R = 6371
        lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
        dlat = lat2 - lat1
        dlon = lon2 - lon1
        a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
        c = 2 * atan2(sqrt(a), sqrt(1 - a))
        return R * c

    def __fetch_data(self):
        obj = FetchData()
        print("Fetching data")
        self.orders_df = obj.fetch_orders_data(c_id=self.w_id)
        self.zip_df = obj.fetch_zips_data()

    def optimize_route(self, c_id):
        self.w_id = c_id
        self.__fetch_data()
        # Assuming `self.zip_df` is a Pandas DataFrame containing 'loadid', 'lat', and 'lng' columns.

        # Generate distance matrix
        zips = self.zip_df["loadid"].tolist()
        distance_matrix = pd.DataFrame(index=zips, columns=zips)

        # Populate distance matrix using the Haversine formula
        for i, row1 in self.zip_df.iterrows():
            for j, row2 in self.zip_df.iterrows():
                if i != j:  # No need to calculate distance for the same point
                    distance_matrix.loc[row1["loadid"], row2["loadid"]] = self.haversine(
                        row1["lat"], row1["lng"], row2["lat"], row2["lng"]
                    )
                else:
                    distance_matrix.loc[row1["loadid"], row2["loadid"]] = 0  # Distance to itself is 0

        distance_matrix = distance_matrix.astype(float)

        # Convert coordinates to a format suitable for BalancedKMeans
        coordinates = self.zip_df[['lat', 'lng']].values.tolist()

        # Perform balanced k-means clustering
        num_trucks = 2  # Set the number of clusters (trucks)
        obj = BalancedKMeans(coordinates, num_trucks)
        clusters = obj.balanced_kmeans()
        print(clusters)

        # Process clusters with Ant Colony Optimization (ACO)
        num_ants = 10
        num_iterations = 100
        alpha = 1  # Importance of pheromone
        beta = 3  # Importance of distance
        evaporation_rate = 0.5
        q = 100
        modified_orderings = []
        best_distances = []

        # Run ACO for each cluster
        for truck_id, cluster in enumerate(clusters):
            print(f"\nTruck {truck_id + 1} routes:")
            cluster_load_ids = [zips[idx] for idx in cluster]  # Map cluster indices back to load IDs
            cluster_matrix = distance_matrix.loc[cluster_load_ids, cluster_load_ids].values  # Extract sub-matrix

            # Initialize and run ACO
            aco = AntColonyOptimization(
                cluster_matrix, num_ants, num_iterations, alpha, beta, evaporation_rate, q
            )
            best_route, best_distance = aco.run()
            modified_orderings.append(best_route)
            best_distances.append(best_distance)
            print(f"Best Route: {best_route}, Best Distance: {best_distance}")

        final_cluster_orders = []
        for cluster_indices, modified_order in zip(clusters, modified_orderings):
            # Map modified order directly to loadid using the cluster indices
            reordered_loadids = [self.zip_df.iloc[cluster_indices[i]]['loadid'] for i in modified_order]
            final_cluster_orders.append(reordered_loadids)

        print("Showing final clusters")
        print(final_cluster_orders)
