import pandas as pd
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
        self.orders_df = obj.fetch_orders_data(w_id=self.w_id)
        self.zip_df = obj.fetch_zips_data()

    @staticmethod
    def __write_data(data):
        print("Writing data to db")
        obj = WriteData()
        obj.write_data(data)

    def create_clusters(self, w_id: str):
        self.w_id = w_id
        self.__fetch_data()
        # self.orders_df = self.orders_df.rename(columns={"dest_zip_id": "zip"})
        zips = self.zip_df["order_id"].tolist()
        distance_matrix = pd.DataFrame(index=zips, columns=zips)
        for i, row1 in self.zip_df.iterrows():
            for j, row2 in self.zip_df.iterrows():
                distance_matrix.loc[row1["order_id"], row2["order_id"]] = self.haversine(
                    row1["lat"], row1["lng"], row2["lat"], row2["lng"]
                )
        distance_matrix = distance_matrix.astype(float)

        distance_matrix_miles = distance_matrix * 0.621371
        radius_threshold = 1000
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
                "Cluster Group ID": [f"CG {i + 1}" for i in range(len(clusters))],
                "Order Ids": [", ".join(map(str, cluster)) for cluster in clusters]
            }
        )

        print("Final Cluster Groups: ")
        print(cluster_df)

        print(clusters)

        print("New cluster group: ")
        grouped_data = [
            {"groupid": f"CG{i + 1}", "loadid": loadid}
            for i, group in enumerate(clusters)
            for loadid in group
        ]
        cluster_df_2 = pd.DataFrame(grouped_data)
        print(cluster_df_2)

        transformed_data = [
            (f"CG{i + 1}", loadid, datetime.utcnow())
            for i, group in enumerate(clusters)
            for loadid in group
        ]

        self.__write_data(transformed_data)
