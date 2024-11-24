import pandas as pd
import numpy as np
from datetime import datetime
from math import radians, sin, cos, sqrt, atan2
from data_operations import FetchData, WriteData
from interface.ICreateClusters import ICreateClusters


class CreateClusters(ICreateClusters):

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
        self.orders_df = obj.fetch_orders_data(g_id=self.w_id)
        self.zip_df = obj.fetch_zips_data()

    @staticmethod
    def __write_data(data):
        print("Writing data to db")
        obj = WriteData()
        obj.write_data(data)

    def create_clusters(self, g_id: str):
        self.w_id = g_id
        self.__fetch_data()
        print("Zip data")
        print(self.zip_df)
        # self.orders_df = self.orders_df.rename(columns={"dest_zip_id": "zip"})
        zips = self.zip_df["loadid"].tolist()
        distance_matrix = pd.DataFrame(index=zips, columns=zips)
        for i, row1 in self.zip_df.iterrows():
            for j, row2 in self.zip_df.iterrows():
                distance_matrix.loc[row1["loadid"], row2["loadid"]] = self.haversine(
                    row1["lat"], row1["lng"], row2["lat"], row2["lng"]
                )
        distance_matrix = distance_matrix.astype(float)

        distance_matrix_miles = distance_matrix * 0.621371
        radius_threshold = 500
        clusters = []
        visited = set()

        for zip_code in distance_matrix_miles.index:
            if zip_code not in visited:
                # Create a new cluster
                cluster = [zip_code]
                visited.add(zip_code)

                neighbors = distance_matrix_miles.loc[zip_code][
                    distance_matrix_miles.loc[zip_code] <= radius_threshold
                    ].index.tolist()

                for neighbor in neighbors:
                    if neighbor not in visited:
                        cluster.append(neighbor)
                        visited.add(neighbor)

                clusters.append(cluster)

        # Convert clusters to a DataFrame for better visualization
        cluster_df = pd.DataFrame(
            {
                "Cluster ID": [f"C{i + 1}" for i in range(len(clusters))],
                "loadid": [", ".join(map(str, cluster)) for cluster in clusters]
            }
        )

        print("Final Cluster: ")
        print(cluster_df)

        # transformed_data = [
        #     (f"C{i + 1}", loadid, datetime.utcnow(), g_id)
        #     for i, group in enumerate(clusters)
        #     for loadid in group
        # ]

        transformed_data = [
            (cluster_id, loadid.strip(), datetime.utcnow(), j + 1, g_id)
            for _, row in cluster_df.iterrows()
            for j, loadid in enumerate(row['loadid'].split(','))
            for cluster_id in [row['Cluster ID'].strip()]
        ]

        print("Transformed Data")
        print(transformed_data)

        self.__write_data(transformed_data)
