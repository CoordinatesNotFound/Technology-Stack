# YAML & JSON



## 1 YAML

- Key Value Pair

  ```
  fruit: apple
  vegetable: carrot
  meat: chicken
  ```

- Array/List (Ordered)

  ```
  fruits:
  - apple
  - orange
  - blueberry
  
  vegetables:
  - carrot
  - tomato
  ```

- Dictionary/Map (Unordered)

  ```
  banana:
  	calaries: 105
  	fat: 0.4g
  	carbs: 27g
  ```

  > Equal number of spaces before each item under one category





## 2 JSON

- JSON Path

  - Data
    ```
    {
    	"car": {
    		"color": "red",
    		"price": "$20000"
    	}
    }
    ```

  - Query
    ```
    "car"
    ```

  - Result
    ```
    {
    		"color": "red",
    		"price": "$20000"
    }
    ```

  - Linux Command
    ```bash
    cat xxx.json | jpath $.list[0].property1
    ```

  - Wild Card
    ```bash
    $.*.car
    
    $.cars[*].price
    ```

- JSON Lists

  - Get x^th^ element
    ```
    $[x-1]
    ```

  - Get x^th^ and y^th^ element
    ```
    $[x-1,y-1]
    ```

  - Get x^th^ to y^th^ element (not including  y^th^ )
    ```
    $[x-1:y-1]
    ```

  - Get x^th^ to y^th^ element (including  y^th^ )
    ```
    $[x-1:y]
    ```

  - Get x^th^ to y^th^ element with STEP z(not including  y^th^ )
    ```
    $[x-1:y-1:z]
    ```

  - Get the last element

    ```
    $[-1]
    $[-1:]
    ```

    

​	