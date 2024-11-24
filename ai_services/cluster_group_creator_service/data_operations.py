import psycopg2
import pandas as pd
from interface.IFetchData import IFetchData
from interface.IWriteData import IWriteData
from config.path_config import db_params, db_name


class FetchData(IFetchData):

    def __init__(self):
        self.db_params = db_params
        self.db_name = db_name
        self.order_data = None

    def fetch_orders_data(self, w_id: str = "W11001"):
        try:
            conn = psycopg2.connect(**self.db_params)
            cursor = conn.cursor()

            table_name = "t_orders"
            query = f"""
                        SELECT *
                        FROM "{self.db_name}".{table_name} 
                        WHERE current_wid = %s
                        """
            cursor.execute(query, (w_id,))
            # Fetch all rows
            rows = cursor.fetchall()
            # Get column names
            col_names = [desc[0] for desc in cursor.description]

            # Convert to Pandas DataFrame
            df = pd.DataFrame(rows, columns=col_names)
            self.order_data = df.copy()
            print("Order data fetched")
            print(self.order_data.head(10))

            cursor.close()
            conn.close()

            return df

        except psycopg2.Error as e:
            print(f"Error: {e}")
            return None

    def fetch_zips_data(self):
        try:
            zips = list(self.order_data["dest_zip_id"].unique())
            zips_string = f"({', '.join(map(str, zips))})"
            print(zips_string)
            conn = psycopg2.connect(**self.db_params)
            cursor = conn.cursor()

            table_name = "zips"
            query = f"""
                    SELECT t.order_id as order_id, z.lat as lat, z.lng as lng 
                    FROM "{self.db_name}".{table_name} z
                    JOIN "{self.db_name}".t_orders t 
                    ON CAST(t.dest_zip_id AS INTEGER) = z.zip
                    WHERE zip IN {zips_string}
                    """
            print(query)
            cursor.execute(query)
            # Fetch all rows
            rows = cursor.fetchall()
            # Get column names
            col_names = [desc[0] for desc in cursor.description]

            # Convert to Pandas DataFrame
            df = pd.DataFrame(rows, columns=col_names)

            cursor.close()
            conn.close()

            return df

        except psycopg2.Error as e:
            print(f"Error: {e}")
            return None


class WriteData(IWriteData):

    def __init__(self):
        self.db_params = db_params

    def write_data(self, data):
        cursor = None
        conn = None
        try:
            # Connect to PostgreSQL
            conn = psycopg2.connect(**db_params)
            cursor = conn.cursor()

            # Insert data into the table
            insert_query = """
            INSERT INTO "staging".cluster_group (groupid, loadid, updatedon) VALUES (%s, %s, %s);
            """
            cursor.executemany(insert_query, data)

            conn.commit()
            print(f"Successfully inserted {len(data)} rows.")
        except Exception as e:
            print(f"Error: {e}")
        finally:
            if cursor:
                cursor.close()
            if conn:
                conn.close()
