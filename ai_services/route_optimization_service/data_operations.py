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

    def fetch_orders_data(self, c_id: str = "C1"):
        try:
            conn = psycopg2.connect(**self.db_params)
            cursor = conn.cursor()

            table_name = "clusters"
            query = f"""
                        SELECT loadid
                        FROM "staging".{table_name} 
                        WHERE clusterid = %s
                        """
            print(query)
            cursor.execute(query, (c_id,))
            rows = cursor.fetchall()
            col_names = [desc[0] for desc in cursor.description]

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
            loads = list(self.order_data["loadid"].unique())
            loads_string = ", ".join(f"'{load}'" for load in loads)
            print(loads_string)
            conn = psycopg2.connect(**self.db_params)
            cursor = conn.cursor()

            table_name = "zips"
            query = f"""
                    SELECT 
                        t.order_Id as loadId,
                        z.lat AS lat,
                        z.lng AS lng
                    FROM 
                        "{self.db_name}".t_orders t
                    JOIN 
                        "{self.db_name}".{table_name} z
                    ON 
                        CAST(t.dest_zip_id AS INTEGER) = z.zip
                    WHERE 
                        t.order_Id IN ({loads_string})
                    """
            print(query)
            cursor.execute(query)
            rows = cursor.fetchall()
            col_names = [desc[0] for desc in cursor.description]

            df = pd.DataFrame(rows, columns=col_names)

            cursor.close()
            conn.close()

            return df

        except psycopg2.Error as e:
            print(f"Error: {e}")
            return None


class WriteData(IWriteData):

    def write_data(self, data):

        cursor = None
        conn = None
        try:
            # Connect to PostgreSQL
            conn = psycopg2.connect(**db_params)
            cursor = conn.cursor()

            # Insert data into the table
            insert_query = """
                    INSERT INTO "staging".clusters (clusterid, loadid, updatedon, seq_no, group_id) VALUES (%s, %s, %s, %s, %s);
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
