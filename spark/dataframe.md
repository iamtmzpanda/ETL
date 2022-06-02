
### Read & Write

```scala
// scala
// read from csv
import org.apache.spark.sql.SparkSession
val spark = SparkSession
  .builder()
  .config(sparkConf) // .config("spark.config.option", "value")
  .getOrCreate()
  
val df = spark
  .read
  .csv("src/main/resources/question_tags_10K.csv") // .parquet("resources/employees")
  .option("header", "true")
  .option("inferSchema", "true")  
  
df.show()
```
```scala
// scala
// write to parquet
df.write
  .mode("overwrite")
  .parquet(path)
  
  
// write to hive
df.write
  ..partitionBy("$partition_column") // ??
  .mode(SaveMode.Overwrite)
  .saveAsTable("dbName.tableName");

  
```
### Stats

```scala
// scala
// schema
df.printSchema
// deduplicate
df.distinct // df.dropDuplicate(["col_1", "col_2"]) 


```
```sql
-- SQL
-- schema
DESCRIBE table
-- deduplicate
SELECT DISTINCT * FROM table
```

### Query
#### where, group by, order by
```scala
// scala
import spark.implicits._  // This import is needed to use the $-notation
import org.apache.spark.sql.functions._
df.filter($"invoiceDate".between("2022-03-01", "2022-06-01"))
  .groupBy("accountId")
  .max("amount").alias("maxInvoiceAmount") // Using agg() function we can calculate many aggregations at one time
  .filter($"maxInvoiceAmount" > 0)
  .orderBy($"maxInvoiceAmount".desc) 
```

```sql
-- SQL
-- GROUP BY
-- WHERE
SELECT AccountId, MAX(Amount)
FROM invoice 
WHERE InvoiceDate > date('2022-03-01') and InvoiceDate < date('2022-06-01') 
GROUP BY AccountId
HAVING MAX(Amount) > 0
ORDER BY MAX(Amount) DESC;
```

#### window function, join
```scala
// scala
// window function
import org.apache.spark.sql.expressions.Window
import org.apache.spark.sql.functions._
empDF.withColumn("dense_rank",dense_rank().over(Window.partitionBy("department").orderBy("salary")))
  .join(deptDF,empDF("departmentId") ===  deptDF("id"),"inner")
  .filter($"dense_rank" <= 3)
  .select($"deptDF.Name".alias("Department"),
          $"empDF.Name".alias("Employee"),
          $"empDF.Salary"
         )
```

```sql
-- SQL
-- window function 
WITH Temp AS
(
    SELECT *, DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS 'Rank'  		
    FROM Employee  
)
SELECT Department.Name AS Department, Temp.Name AS Employee, Temp.Salary 
FROM Temp
JOIN Department 
ON Temp.DepartmentId = Department.Id
WHERE Temp.Rank <= 3

```
#### case when
```scala
df.withColumn('start', concat(
                      when(col('start') == 'text', lit('new'))
                      .otherwise(col('start))
                     , lit('asd')
                     )

```

```sql


```


### UDFs
```scala
// scala
// udf
import org.apache.spark.sql.functions.udf
val captalizeUDF = udf(
  (str:String)=>
    str.split(" ").map(word=>word.trim.capitalize).mkString(" ")) //  _.split(" ").map(_.trim.capitalize).mkString(" ")
  )
df.withColumn("col_n", captalizeUDF("text")).show


spark.udf.register("strLen", (str: String) => str.length())
df.registerTempView
spark.sql("select name,strLen(name) as name_len from user").show


// map
df.map {
  r => foo(r.getAs[Long](0), r.getAs[Long](0) + 1)
  }
  

// custom method
df.snakeCaseColumns
  .write
  .save()


// struct 
// case class

```



