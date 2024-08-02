# Designing and Building Scalable Web Applications

[TOC]



## 1 Scalability



### 1.1 Definition

- By scalability, we mean that **when the load offered to the service increases, an incremental and linear increase in hardware can maintain the same per-user level of service**.
- There are, in principle, two strategies for scaling software: 
  - **vertical scaling** 
    - Vertical scaling refers to adding more resources to the current server, while horizontal scaling refers to adding more servers to handle the task.
    - Vertical scaling means adding more resources to the current server. This includes upgrading hardware resources such as the number of available processors and the amount of available memory, which in turn improves the processing power of the single server.
  - **horizontal scaling**
    - horizontal scaling refers to adding more servers to handle the task.
    - Horizontal scaling means adding more servers to handle the workload.



### 1.2 Scalability laws

- Amdahl's Law

  - Amdahl's Law posits that programs have parts that can be parallelized and parts that cannot be parallelized. The total execution time of a program is the sum of the execution time of the parts that can be parallelized and the parts that cannot be parallelized. Through identification of parts that cannot be parallelized and parts that can be parallelized, Amdahl's Law can be used to determine a maximum theoretical improvement in program execution time when parallelizable parts are parallelized over a number of workers.
    $$
    Improvement = N / (1 + p(N - 1))
    $$
    The formula for Amdahl's Law is outlined above. The `p` refers to the proportion of the program that cannot be parallelized and `N` refers to the number of workers to which the parallel work can be divided to.

- Gunther's Universal Scalability Law

  - Amdahl's Law does not account for communication between the workers (e.g. synchronization of tasks), however, which Gunther's Universal Scalability Law adds.
    $$
    Improvement = N / (1 + p(N - 1) + pyN(N - 1))
    $$
    The formula for Gunther's Universal Scalability Law is outlined above. Similar to Amdahl's Law, `p` refers to the proportion of the program that cannot be parallelized, and `N` refers to the number of workers to which the parallel work can be divided. The `y` refers to a communication overhead (e.g. using shared data, invalidating caches, etc).





## 2 Measuring Performance



### 2.1 Performance viewpoints

- Server-side performance
  - Multiple metrics can be used to assess the performance of a web server (and the backend systems in general). Classic metrics include 
    - **response time** (the time it takes for the server to respond to the request from the client)
    - **throughput** (the number of requests that a server can handle per second)
    - **failure rate** (the number of failed requests when processing requests from the client)
    - in addition, given access to the server, one can measure **memory utilization, disk i/o, network i/o**, etc.
- Client-side performance
  - The Core Web Vitals (in 2020) focus on loading, interactivity, and visual stability of the studied web site. 
    - For **loading**, the metrics focus on [largest contentful paint](https://web.dev/lcp/), which measures the time it takes to load the largest element of the web site. 
    - For **interactivity**, the metrics focus on [first input delay](https://web.dev/fid/), which measures the time it takes for the browser to react to an interaction such as clicking a button. 
    - For **visual stability**, the metrics focus on [cumulative layout shift](https://web.dev/cls/), which measures bursts of layout shifts -- e.g. image loading and content moving -- in the application.



### 2.2 Measuring performance

- Installing k6

  - `brew install k6`

- Basic testing

  - simple-pormance-test.js
    ```javascript
    import http from "k6/http";
    
    export default function () {
      http.get("http://localhost:7777");
    }
    ```

  - terminal command

    - `k6 run simple-performance-test.js`

      ```shell
       execution: local
           script: simple-performance-test.js
           output: -
      
        scenarios: (100.00%) 1 scenario, 1 max VUs, 10m30s max duration (incl. graceful stop):
                 * default: 1 iterations for each of 1 VUs (maxDuration: 10m0s, gracefulStop: 30s)
      
      
      running (00m00.0s), 0/1 VUs, 1 complete and 0 interrupted iterations
      default ✓ [======================================] 1 VUs  00m00.0s/10m0s  1/1 iters, 1 per VU
      
           data_received..................: 136 B 49 kB/s
           data_sent......................: 80 B  29 kB/s
           http_req_blocked...............: avg=338.53µs min=338.53µs med=338.53µs max=338.53µs p(90)=338.53µs p(95)=338.53µs
           http_req_connecting............: avg=154.27µs min=154.27µs med=154.27µs max=154.27µs p(90)=154.27µs p(95)=154.27µs
           http_req_duration..............: avg=891.96µs min=891.96µs med=891.96µs max=891.96µs p(90)=891.96µs p(95)=891.96µs
             { expected_response:true }...: avg=891.96µs min=891.96µs med=891.96µs max=891.96µs p(90)=891.96µs p(95)=891.96µs
           http_req_failed................: 0.00% ✓ 0         ✗ 1
           http_req_receiving.............: avg=70.81µs  min=70.81µs  med=70.81µs  max=70.81µs  p(90)=70.81µs  p(95)=70.81µs
           http_req_sending...............: avg=78.22µs  min=78.22µs  med=78.22µs  max=78.22µs  p(90)=78.22µs  p(95)=78.22µs
           http_req_tls_handshaking.......: avg=0s       min=0s       med=0s       max=0s       p(90)=0s       p(95)=0s
           http_req_waiting...............: avg=742.92µs min=742.92µs med=742.92µs max=742.92µs p(90)=742.92µs p(95)=742.92µs
           http_reqs......................: 1     362.31359/s
           iteration_duration.............: avg=1.46ms   min=1.46ms   med=1.46ms   max=1.46ms   p(90)=1.46ms   p(95)=1.46ms
           iterations.....................: 1     362.31359/s
      ```

  - metrics 

    - `http_req_duration` outlines the total time for the request
    -  `http_req_failed` shows the proportion and number of failed requests
    -  `http_reqs` shows the total number of requests. 
  
- Providing options to k6

  - simple-performance-test.js
    ```javascript
    import http from "k6/http";
    
    export const options = {
      duration: "5s",
      vus: 10,
      summaryTrendStats: ["avg", "p(99)"]
    };
    
    export default function () {
      http.get("http://localhost:7777");
    }
    ```

  - There is a full documentation of the [k6 options](https://k6.io/docs/using-k6/k6-options/reference/) available at https://k6.io/docs/using-k6/k6-options/reference/. 

- Testing more complex requests

  - The http module that the test imports provides a variety of functions that can be used for writing the test. 

  - simple-performance-test.js
    ```javascript
    import http from "k6/http";
    
    export const options = {
      duration: "5s",
      vus: 10,
      summaryTrendStats: ["avg", "p(99)"],
    };
    
    export default function () {
      http.get("http://localhost:7777");
      http.get("http://localhost:7777/items");
      http.post(
        "http://localhost:7777/items",
        JSON.stringify({ name: "hamburger" })
      );
    }
    ```






## 3 Multiple Servers and Load Balancing



### 3.1 Multiple servers

- deploy configuration

  - Docker Compose comes with a configuration related to the [deployment and running of services](https://docs.docker.com/compose/compose-file/compose-file-v3/#deploy). Using [deploy](https://docs.docker.com/compose/compose-file/compose-file-v3/#deploy) configuration, we can specify a number of container [replicas](https://docs.docker.com/compose/compose-file/compose-file-v3/#replicas) for a service. 
    ```yaml
        deploy:
          replicas: 2
    ```

  
  > 【docker-compose vs docker compose】
  > There are two variants of the command used to run Docker Compose. The docker-compose refers to an older version of Docker Compose (Python-based, v1), while docker compose refers to a newer version of Docker Compose (Go-based, v2).
  >
  > For the deploy configuration, we'll rely the newer version.
  
- port mapping

  - Using `"7777-7778:7777"`, we state that the ports `7777` and `7778` can be used for exposing the port `7777` from the docker container running a replica of the service `app`. With this, when launching multiple replicas, each of the replicas attempt to take one port from the available range.
    ```yaml
        ports:
          - "7777-7778:7777"
    ```

  - Then the `app` configuration looks like:
    ```yaml
      items-api:
        build: items-api
        image: items-api
        restart: "no"
        volumes:
          - ./items-api/:/app
          - ./app-cache/:/app-cache
        ports:
          - "7777-7778:7777"
        depends_on:
          - database
          - flyway
        env_file:
          - project.env
        deploy:
          replicas: 2
    ```
    
    

### 3.2 Load balancing

- Conception

  - Load balancing means **distributing requests across multiple servers**. It is used to share work between available servers for the purposes of avoiding the situation, where an individual server is overwhelmed with work. 
  - Load balancing is realized by using a **load balancer**, which is a concrete piece of hardware (or software) responsible for directing incoming requests. 
  - There exists a wide variety of load balancers, each intended for specific use cases. These include application-level (OSI Layer 7) load balancers, transport-level (OSI Layer 4) load balancers, DNS load balancers, hardware load balancers, global server load balancers, cloud-based load balancers, and so on.
  - Application-level load balancers
    - Application-level load balancers operate at the application layer of the OSI model (layer 7). They are responsible for distributing traffic to servers based on the content of the request. As they work on the application level, they have access to information such as the URL, cookie, and header values.
    - Application-level load balancers can also be used for managing secure connections. In practice, when application-level load balancers are used for managing secure connections, the connection between the client and the load balancer is encrypted, while the connection from the load balancer to the individual servers is not encrypted. This frees up resources from the servers, while providing a centralized entrypoint for maintaining a secure connection
  - Transport-level load balancers
    - Transport-level (also network-level) load balancers on the other hand operate at the transport level of the OSI model (layer 4). Similar to the application-level load balancers, they are responsible for distributing traffic to servers. However, instead of using content of the requests, transport-level load balancers use protocol-level information such as the IP address and port number for distributing traffic.
    - When compared to application-level load balancers, transport-level load balancers are faster and simpler, as they make decisions based on a smaller set of data. Due to this, they can handle a large number of connections and requests. Due to their efficiency, transport-level load balancers are also useful for handling denial of service attacks, where the application is bombarded with large numbers of requests; as a remedy, load balancers can be configured to e.g. rate limit connections or to limit connections per ip.

- Strategies for load balancing

  - Picking a server at random and directing the request to it.
  - Using round robin to pick the next server -- i.e. directing incoming requests to the servers in a cyclic order.
  - Sticking clients to specific servers (e.g. with IP hash) -- i.e. using a hash function to map incoming requests to a specific server based on the client's IP address. This is used to ensure that requests from the same client are directed to the same server, which required e.g. when servers are used for maintaining session state.
  - Picking a server based on open connections or smallest response time. These require keeping a track of open connections or monitoring the response time.

- Adding nginx as a service

  - configuration in docker-compose.yml
    ```yaml
      nginx:
        image: nginx:latest
        volumes:
          - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
        depends_on:
          - items-api
        ports:
          - 7800:7800
    ```

    - define `items-api` as a dependency for the NGINX service, which means that the NGINX service will wait for the `items-api` to start up before launching. 
    - expose a port from `nginx`, mapping the internal port `7800` to the public port `7800`.

  - condiguration in nginx.conf

    ```conf
    worker_processes 1;
    
    events {
      worker_connections 1024;
    }
    
    http {
    
      upstream items-api {
        server items-api:7777;
      }
    
      server {
        listen 7800;
    
        location / {
          proxy_pass http://items-api;
        }
      }
    }
    ```

    - create a folder called `nginx` and place the configuration file (called `nginx.conf`) to the folder
    - The configuration describes the use of one worker process for handling incoming connections, where the worker could have up to 1024 concurrent open connections. It then proceeds to describe how to handle http traffic (within the `http` block). There, we first label the service `items-api` running on port `7777` as `items-api`, and then define a server that listens for incoming connections on the port `7800`. In the server, for all incoming requests (`location /`), we delegate (`proxy_pass`) them to service earlier labeled as `items-api`.

- Hiding API

  - With information about how the Docker network works, we can hide the items-api port from the world, leading to a situation where the port 7777 (or 7778) no longer responds to requests from outside. As we still want that the port 7777 is available within the Docker network, we use the configuration option expose to expose the port from the container (while omitting publishing the port for all).
    ```yaml
      nginx:
        image: nginx:latest
        volumes:
          - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
        depends_on:
          - items-api
        ports:
          - 7800:7800
    
      items-api:
        build: items-api
        image: items-api
        restart: "no"
        volumes:
          - ./items-api/:/app
          - ./app-cache/:/app-cache
        expose:
          - 7777
        depends_on:
          - database
          - flyway
        env_file:
          - project.env
        deploy:
          replicas: 2
    ```

- Internal and external ports

  - How Docker networks work:
  
    - When we launch an application using docker compose up, we are actually creating a **network of services**. 
  
    - The services have names and ports that are **internal** to the network, which can be opened up to the world if we choose to do so. The names in the internal network correspond to **names of our services** in the docker-compose.yml file
  
      > as an example, items-api is identified as items-api in the internal network.
  
  - Docker takes internally care of replicas, balancing traffic. 
  
    - That is, if a request is made to items-api within the network, Docker directs the request to one of the replicas of items-api. 
    - When we declare in the NGINX configuration that traffic to / should be delegated to the service items-api in the NGINX configuration, the actual mapping of items-api to a container is handled by **Docker**.





## 4 Caching



### 4.1 Caching

- Conception
  - Caching refers to **storing data in a temporary location that provides faster access to the data than the original data location**. 
  - It is used to increase the efficiency of retrieving data that has already been retrieved once. 
  - benefits:
    - improved performance -- caching can speed up the retrieval of the data, resulting in a faster web application; 
    - reduced server load -- caching can reduce the number of requests made to the server, reducing the load on the server; 
    - increased scalability -- through reducing server load, caching can help increase the scalability of a web application. 
    - offline access -- caching can be used to enable offline access to data, and depending on the cost model of the hosting solution, caching may also lead to reduced hosting costs.
  - downsides:
    - Being hard to implement properly. If cache invalidation is not properly implemented, the use of caching can lead to stale data, meaning that the data is no longer accurate or up-to-date. 
    - Caching also adds (some) complexity to the application, and may require introducing additional services. 
    - The use of caching also leads to an increased need of resources, as the cached data needs to be stored. 
    - If not properly secured, caching of data may also lead to security risks.



### 4.2 Client-side caching

- Cache control

  - The header `Cache-Control` is used to enable caching for a resource and, optionally, to set an age for the resource. 

  - As an example, when asking for a resource at `/images/retro-sax-guy.gif`, the HTTP request could be as follows.
    ```
    GET /images/retro-sax-guy.gif HTTP/1.1
    (headers)
    ```

  - While the response, with `Cache-Control` header, could be as follows.
    ```
    HTTP/1.1 200 OK
    Cache-Control: private, max-age: 86400
    
    ... data ...
    ```

    - The `max-age` option in the header is given in seconds. Now, based on the response, the resource `/images/retro-sax-guy.gif` could be cached by the browser, and the browser would not need to retrieve the resource during the next 24 hours (24\*60\*60 = 86400).

- Last modified & If-Modified-Since

  - The `Last-Modified` header provides additional information about the resource being retrieved. When the `Last-Modified` header is used, the server responds with information on when the requested resource was last changed.

  - Again, when retrieving the resource at `/images/retro-sax-guy.gif`, the request could be as follows.
    ```
    GET /images/retro-sax-guy.gif HTTP/1.1
    (headers)
    ```

  - When the `Last-Modified` header is in use, the response would be as follows -- in the example below, we've also included the `Cache-Control` header, as they are typically used jointly.

    ```text
    HTTP/1.1 200 OK
    Cache-Control: private, max-age: 86400
    Last-Modified: Mon, 31 Oct 2022 09:45:00 GMT
    
    ... data ...
    ```

  - Now, based on the response, the browser would know not to even attempt to retrieve the resource in the next 24 hours. After that, when attempting to retrieve the resource, the browser sends information about the known last modified date of the resource, which was previously received as a part of the response from the server. The header that contains the last modified date in the request is `If-Modified-Since`.
    ```
    GET /images/retro-sax-guy.gif HTTP/1.1
    If-Modified-Since: Mon, 31 Oct 2022 09:45:00 GMT
    (further headers)
    ```

  - Now, when the server receives such a request, it can compare the date in the `If-Modified-Since` header with the actual modification date of the resource. If the resource has been modified since, the response would contain the data and a new `Last-Modified` header, as follows.
    ```
    HTTP/1.1 200 OK
    Cache-Control: private, max-age: 86400
    Last-Modified: Fri, 13 Jan 2023 09:45:00 GMT
    
    ... data ...
    ```

  - On the other hand, if the resource would not have been modified, there is no need to send the data again. In this case, the server could return a response with the status code `304`, indicating that the resource has not been modified.
    ```
    HTTP/1.1 304 Not Modified
    (headers)
    ```

- Etag & If-None-Match

  - The `ETag` header provides an unique identifier matching the resource that is being retrieved. It is generated on the server to correspond to the resource, and sent to the client. When using the `ETag` header, the initial HTTP request is again similar to the previous HTTP requests.
    ```
    GET /images/retro-sax-guy.gif HTTP/1.1
    (headers)
    ```

  - With a server supporting the `ETag` header, the response could be as follows. The `unique identifier-from-server` would be a string representation of the content of the requested resource

    ```text
    HTTP/1.1 200 OK
    Cache-Control: private, max-age: 86400
    ETag: "unique-identifier-from-server"
    
    ... data ...
    ```

  - Now, when the client retrieves the resource for the next time (after the initial 24 hour delay determined in `Cache-Control`), the request for the resource would have a header `If-None-Match` that would contain the value previously received from the server.
    ```
    GET /images/retro-sax-guy.gif HTTP/1.1
    If-None-Match: unique-identifier-from-server
    ```

  - Similarly to the `Last-Modified` header, when the server receives a request with `If-None-Match`, it can compare the value in the `If-None-Match` header with the actual ETag of the resource. If the value of `If-None-Match` and the `ETag` do not match, the response would contain the data and a new `ETag` header, as follows.

    ```text
    HTTP/1.1 200 OK
    Cache-Control: private, max-age: 86400
    ETag: "another-unique-identifier-from-server"
    
    ... data ...
    ```

  - If the resource would not have been modified, there would be no need to send the data again. The server would again indicate this with the status code `304`.
    ```
    HTTP/1.1 304 Not Modified
    (headers)
    ```

    > When compared with the `Last-Modified` header, the benefits of the `ETag` header include granularity. If a resource changes twice within a second, the use of the `Last-Modified` header could lead to stale cache, as the granularity of the format is in seconds. For `ETag`, the value would be changed whenever the resource would change.



### 4.3 Server-side caching

- Caching service

  - building caching tool in cacheUtil.js
    ```javascript
    const cache = new Map();
    
    const cacheMethodCalls = (object, methodsToFlushCacheWith = []) => {
      const handler = {
        get: (module, methodName) => {
          const method = module[methodName];
          return async (...methodArgs) => {
            if (methodsToFlushCacheWith.includes(methodName)) {
              cache.clear();
              return await method.apply(this, methodArgs);
            }
    
            const cacheKey = `${methodName}-${JSON.stringify(methodArgs)}`;
    
            if (!cache.has(cacheKey)) {
              cache.set(cacheKey, await method.apply(this, methodArgs));
            }
    
            return cache.get(cacheKey);
          };
        },
      };
    
      return new Proxy(object, handler);
    };
    
    export { cacheMethodCalls };
    ```

  - caching service
    ```javascript
    import * as itemService from "./services/itemService.js";
    import { cacheMethodCalls } from "./util/cacheUtil.js";
    
    // ..
    
    const cachedItemService = cacheMethodCalls(itemService, ["addItem"]);
    
    const handleGetItem = async (request, urlPatternResult) => {
      const id = urlPatternResult.pathname.groups.id;
      return Response.json(await cachedItemService.getItem(id));
    };
    
    const handleGetItems = async (request) => {
      return Response.json(await cachedItemService.getItems());
    };
    
    const handlePostItems = async (request) => {
      // assuming that the request has a json object and that
      // the json object has a property name
      const item = await request.json();
      await cachedItemService.addItem(item.name);
      return new Response("OK", { status: 200 });
    };
    ```

- Using Redis

  - configuration in docker-compose.ymal
    ```yaml
      redis:
        image: redis:latest
        command: redis-server /usr/local/etc/redis/redis.conf
        volumes:
          - ./redis/redis.conf:/usr/local/etc/redis/redis.conf
        expose:
          - 6379
    ```

  - configuration in redis.conf
    ```
    maxmemory 5mb
    maxmemory-policy allkeys-lru
    save ""
    appendonly no
    ```

  - connecting and using redis in cacheUtil.js
    ```javascript
    import { connect } from "../deps.js";
    
    const redis = await connect({
      hostname: "redis",
      port: 6379,
    });
    
    const cacheMethodCalls = (object, methodsToFlushCacheWith = []) => {
      const handler = {
        get: (module, methodName) => {
          const method = module[methodName];
          return async (...methodArgs) => {
            if (methodsToFlushCacheWith.includes(methodName)) {
              await redis.flushdb()
              return await method.apply(this, methodArgs);
            }
    
            const cacheKey = `${methodName}-${JSON.stringify(methodArgs)}`;
            const cacheResult = await redis.get(cacheKey);
            if (!cacheResult) {
              const result = await method.apply(this, methodArgs);
              await redis.set(cacheKey, JSON.stringify(result));
              return result;
            }
    
            return JSON.parse(cacheResult);
          };
        },
      };
    
      return new Proxy(object, handler);
    };
    
    export { cacheMethodCalls };
    ```





## 5 Client-side Web Development



### 5.1 Characterizing client-side development

- Conception
  - Client-side web development focuses on **building functionality where the majority of processing and logic is executed on the client**. 
  - In client-side applications, the browser loads content that is used to create the user interface and to handle user interactions and events. The content is typically HTML, JavaScript, and CSS files, but it could include other types of content such as WebAssembly modules or content such as Flash if supported by the browser. 
  - The interactions that can be handled on the client include form validation, data manipulation, dynamic updates to the shown content, etc, which lead to increased perceived usability.
  - As client-side applications typically run in a browser, **JavaScript** continues to be the main programming language used for client-side development. There are also other options used for development that can be transpiled or compiled into JavaScript, which include Elm, TypeScript, Kotlin, and Dart.



### 5.2 Web rendering approaches

- Serving static files

  - The starting point of all web applications was static web sites, which were served to clients on demand. 
  - The static web sites included static HTML, stylesheets, JavaScript files, images, etc, and were created by hand, possibly using WYSIWYG tools such as DreamWeawer. 
  - The sole role of the server was to **serve the files**.

  > The role of serving files has not changed for the server, but the tasks that servers are used for has since expanded.

- Server-side rendering

  - As additional expectations emerged, including simple things such as not needing to copy and paste the same header and footer content to each and every HTML file, **dynamic functionality** was introduced to web applications. 
  - Server-side rendering is a solution where **HTML is produced on the server programmatically**, for example, by combining multiple files into one, possibly also retrieving data from a database and filling the data into a resulting HTML document.

  - While server-side rendering is classically **done per request**, where an HTML document is produced for each request (omitting caching), some content -- if not all -- can also be generated beforehand.

- Static site generation

  - Static site generation allows serving a site with dynamic content as a static website, which when served requires **no dynamic rendering** from the client or from the server. 

  - This, of course, requires that the content is such that it **does not change per request**. 

    > For example, if a website uses static site generation and depends on contents from a database, the static content needs to be recreated when the contents of the database change.

- Client-side rendering

  - Client-side rendering allows the creation of web sites where browsers load an HTML document with JavaScript, followed by the **JavaScript being executed**, leading to **retrieving additional content**. 
  - The JavaScript code may, for example, retrieve template HTML code and JSON, merging them programmatically **on the client** to create the shown content. 
  - This allows a situation, where interactions with the server do not require a full page reload, but instead change only parts of a site -- as an example, form data can be sent using JavaScript, which would also be used to process and display the response from the server.

- Hybrid rendering

  - Server-side and client-side rendering are often used in tandem to reach a desired outcome -- this is called hybrid rendering. 
  - The server could, for example, be responsible for creating a outline of the website, which is then sent to the client. 
  - The client, in turn, could fill in parts of the website based on additional information, and react to interactions without the need to reload the full page contents.

- Isomorphic rendering 

  - is an instance of hybrid rendering, where both the client and the server use the same functionality for rendering the content. 
  - In practice, with isomorphic rendering, one could for example receive a rendered website from the server, which would also contain JavaScript for added interactivity. 
  - When the client scrolls the website or interacts with it in a way that requires additional data, the client would retrieve the data from the server (e.g. in JSON format), and render it as an addition to the existing content created on the server.

- Compilation, minification and compression

  - Note that when writing web applications, the development process often involves tooling that processes the written code. As an example, **compilation and transpilation** of (client-side) source code allows developers to use modern language features and syntax, while maintaining compatibility with older browsers.

  - This tooling also often includes support for mechanisms such as **code-splitting**, which allows dividing code into smaller parts, which can be loaded when needed. Although this does not reduce the overall amount of cide, this can reduce the amount of code that is initially sent to the client, improving the perceived performance of the application.
  - In addition, when deploying a website, the source code can also be minified and compressed. **Minification** refers to removing unnecessary characters from the source code, such as white spaces, linebreaks, and comments, shortening variable and function names, and potentially doing other trickery for making the code smaller and faster to download. The result of minification can also be compressed, leading to even smaller content that is again faster to download; the majority of browsers support handling compressed content.



### 5.3 Component-driven development

- The key change has been that instead of defining functionality for a web application as a whole, contemporary client-side web development relies on **component-driven development**. 
- In component-driven development, user interfaces are built out of **components**, which are combined to create the application as a whole. 
- Each individual component can contain logic, markup, and styles, and the frameworks in use are responsible for **hydrating** the components into the site that will be shown to the user, imbuing them with logic for event handling.





## 6 Svelte

> [Introduction • Docs • Svelte](https://svelte.dev/docs/introduction)



### 6.1 Introduction to Svelte

- Conception
  - Svelte is a component-driven JavaScript framework for building client-side web applications. Components written in Svelte consist of JavaScript, HTML template, and styling (but may also omit the first and the last)

- Tooling

  - create a template
    ```bash
    npm create svelte@latest
    ```

  - install dependecies
    ```bash
    npm install
    ```

  - run the application
    ```bash
    npm run dev
    ```



### 6.2 Svelte components

- Component structure

  - Components in Svelte consist of JavaScript (optional), HTML template (mandatory), and style definitions (optional).
    ```svelte
    <script>
      //javascript
    </script>
    
    <!--html-->
    
    <style>
      #style
    </style>
    ```

- Importing components & Passing content
  ```svelte
  export:
  <script>
    //export
    export let xxx;
  </script>
  
  import:
  <script>
    import Yyy from "<file_path>";
  </script>
  
  <Yyy xxx={value} />
  ```



### 6.3 Reactivity and logic

- Reactivity

  - Under the hood, Svelte uses r**eactive programming** to propagate changes to variable values in the user interface. 

- Reactivity and objects

  - The functionality is present only when **assigning values**, and changes to e.g. the internal state of an object are not monitored.

- Properties and reactivity

  - Note that the reactivity does **not** work when **passing properties**.

- Logic

  - Svelte's HTML template code also supports writing basic logic into the templates. 

  - In templates, logic is implemented using blocks.
    ```svelte
    {#if cond1}
    	<!--html-->
    {:else if cond2}
    	<!--html-->
    {:else}
    	<!--html-->
    {/if}
    
    {#each items as item}
       {item}
    {/each}
    ```



### 6.4 State management with stores

- store

  - State in Svelte is managed using stores. Stores are objects that can be imported to any part of the program, that can be subscribed to (to monitor changes), and that can be modified.

  ```javascript
  import { readable} from "svelte/store";
  
  
  let user = localStorage.getItem("userUuid");
  
  if (!user) {
    user = crypto.randomUUID().toString();
    localStorage.setItem("userUuid", user);
  } 
  
  export const userUuid = readable(user);
  ```

  

### 6.5 Using APIs

- Fetch
  - The `fetch` method is an asynchronous method.  
  - The asynchronous functionality is handled using the `then` method in the `Promise` that is returned when `fetch` is called.
  - The `json` method of the `Response` is similarly asynchronous, so that is also handled with the `then` method. 
  - Finally, the response has been received and transformed to a JSON object
- Await
  - Svelte's HTML template has also an `await` block for handling promises in the markup. 
  - We could also implement the above functionality as an asynchronous method, which could be called when the component is loaded. 
  - With the `await` block, we could also show the user an indication that the content is loading (e.g. a spinner).

````svelte
<script>
  const fetchJoke = async () => {
    const response = await fetch('https://simple-joke-api.deno.dev/random');
    return await response.json();
  };

  let jokePromise = fetchJoke();

  const updateJoke = () => {
    jokePromise = fetchJoke();
  };
</script>

<button on:click={updateJoke}>Fetch a joke</button>

{#await jokePromise}
  <p>Loading...</p>
{:then joke}
  <p>Setup: {joke.setup}</p>
  <p>Punchline: {joke.punchline}</p>
{/await}
````







## 7 Astro

> [Getting Started | Docs](https://docs.astro.build/en/getting-started/)



### 7.1 Introduction to Astro

- Conception

  - Astro processes JavaScript on the server, generating static pages that are then served to the client.

    > Astro is a static site generator.

  - Astro is UI framework agnostic, which means that it supports a variety of user interface libraries and frameworks.

- Tooling

  - create a template

    ```bash
    npm create astro@latest
    ```

  - run the application

    ```bash
    npm run dev
    ```



### 7.2 Pages, routes and layouts

- Pages and routing
  - Astro is a multi-page application (MPA) framework and renders (most of) the HTML for each page on the server, building static web sites that can be simply served. 
  - Clicking on a link will lead to a page being loaded from the server, instead of loading e.g. JSON data from the server as would be the case for single-page applications (SPA). This means that the initial load time of a web application built with 
  - Astro can be faster than the initial load time of a single-page applications, as the pages have already been created on the server. On the other hand, subsequent page requests can be slower, as the amount of retrieved data may be larger.

- Layouts
  - Astro provides a mechanism for defining and creating layouts. 



### 7.3 Astro, Svelte, and Docker Compose

- `/items-ui/Dockerfile`

  ```dockerfile
  FROM node:lts-alpine3.17
  
  EXPOSE 3000
  
  WORKDIR /app
  
  ENV PATH /app/node_modules/.bin:$PATH
  
  COPY *.json ./
  
  RUN npm install
  
  COPY . .
  
  CMD [ "astro", "dev" ]
  ```

- `/items-ui/astro.config.mjs`

  ```js
  import { defineConfig } from "astro/config";
  
  import svelte from "@astrojs/svelte";
  
  export default defineConfig({
    integrations: [svelte()],
    server: { port: 3000, host: true },
  });
  ```

- `docker-compose.yaml`

  ```yaml
  // ...
    items-ui:
      build: items-ui
      image: items-ui
      restart: "no"
      volumes:
        - ./items-ui/:/app
        - astro_node_modules:/app/node_modules
      expose:
        - 3000
      depends_on:
        - items-api
  // ...
  ```

- `/nginx/nginx.conf`

  ```
  worker_processes 1;
  
  events {
    worker_connections 1024;
  }
  
  http {
  
    upstream items-api {
      server items-api:7777;
    }
  
    upstream items-ui {
      server items-ui:3000;
    }
  
    server {
      listen 7800;
  
      location /api/ {
        proxy_pass http://items-api/;
      }
  
      location / {
        proxy_pass http://items-ui;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
      }
    }
  }
  ```

  





## 8 Tailwind CSS

> [Installation - Tailwind CSS](https://tailwindcss.com/docs/installation)
>
> [CSS Utility Classes and "Separation of Concerns"](https://adamwathan.me/css-utility-classes-and-separation-of-concerns/)





## 9 Real-time Communication



### 9.1 APIs and polling

- API 
  - API in web applications are typically built using the **request-response** pattern, where a client sends a request which the server then responds to.
  -  APIs in web are often implemented following Representational State Transfer (**REST**), where resources are identified through URIs, representation formats are agreed upon (e.g. JSON), and standard methods such as the HTTP methods are used for both semantics and for exchanging information.
  - The request-response pattern is commonly implemented **synchronously**, where the client sends a request and then waits for a response.

- Long and short polling
  - Long polling 
    - refers to the client sending a request and the server keeping the connection open until a timeout or until there is data that should be sent to the client. 
    - Once the connection times out, it is closed, and the client makes a new request. 
    - On the other hand, if the server sends a response to the client, the client could decide based on the data whether it should make a new request to the server.
  - Short polling 
    - refers to sending a request, to which the server immediately responds. The connection is not kept open. 
    - If the server has data that should be sent to the client, the server will respond with the data. 
    - Otherwise, the response from the server would indicate that the requested data is not yet available. Upon receiving a response, the client decides based on the response whether it should make a new request. If yes, the client would wait for a moment, and send a new request.



### 9.2 Server-sent events

- Conception
  - Server-sent events is a one-directional push-based technology where, once the client has initiated a connection, the server can send events to the client.

- Sending events from server
  ```javascript
  import { serve } from "https://deno.land/std@0.202.0/http/server.ts";
  
  const message = new TextEncoder().encode("data: ping\n\n");
  
  const handleRequest = async (request) => {
    let interval;
  
    const body = new ReadableStream({
      start(controller) {
        interval = setInterval(() => {
          controller.enqueue(message);
        }, 1000);
      },
      cancel() {
        clearInterval(interval);
      },
    });
  
    return new Response(body, {
      headers: {
        "Content-Type": "text/event-stream",
      },
    });
  };
  
  serve(handleRequest, { port: 7777 });
  ```

  or
  [/docs/sse.md | oak@v12.6.1 | Deno](https://deno.land/x/oak@v12.6.1/docs/sse.md?source=) (maybe more practical :)

- Handling events on the client
  ```svelte
  <script>
    import { onMount } from "svelte";
  
    let events = [];
    let eventSource;
  
    onMount(() => {
      eventSource = new EventSource("/api/sse");
      eventSource.onmessage = (event) => {
        events = [...events, event.data];
      };
  
      eventSource.onerror = (event) => {
        console.log(event);
      };
  
      return () => {
        if (eventSource.readyState === 1) {
          eventSource.close();
        }
      };
    });
  
    const closeEventStream = () => {
      eventSource.close();
    };
  </script>
  
  <h2>Server-sent events ({events.length})</h2>
  
  <button on:click={closeEventStream}>Close connection</button>
  
  <ul>
    {#each events as event}
      <li>{event}</li>
    {/each}
  </ul>
  ```

> NGINX configuration must be adjusted to allow server-sent events when used



### 9.3 Web sockets

- Conception
  - For bidirectional communication, one would use web sockets. Web sockets use the WebSocket Protocol instead of HTTP, building on top of TCP.
- Server side
  [Deno.upgradeWebSocket | Runtime APIs | Deno](https://deno.land/api@latest?s=Deno.upgradeWebSocket)
- Client side
  [WebSocket - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)





## 10 Event-driven Architecture



### 10.1 Event-driven architecture

- Event-driven architecture is a design pattern focusing on **producing and consuming events**, which provides means for communicating between services without a need for the services being aware of each other. In other words, in an event-driven architecture, components responsible for creating events and components responsible for handling events are decoupled, and a mechanism is used for passing messages between the decoupled parts.
- Event-driven architecture is present in a wide variety of applications. For example, in user interfaces, events such as pressing a button are typically decoupled from the functionality that processes the press of a button. This can be implemented using event or action listeners, which are used to register functionality that should be executed in the case of the events.



### 10.2 Publish-subscribe pattern

- Publish-subscribe pattern
  - Publish-subscribe is a messaging pattern that has three types of actors: **message producers, message brokers, and message consumers**. 
    - Producers create messages, which they send to brokers. 
    - Brokers receive messages and send them to consumers. Brokers allow decoupling producers and consumers so that they are not aware of each others.
    - Consumers consumes and processes messages.



### 10.3 Message queues

- Conception

  - Message queues are services used for **temporarily storing messages**. 
  - They provide the means to add messages to the queue, and the means to take messages from the queue.
  - Message queues can be used by **brokers** in the publish-subscribe pattern. In such a case, incoming messages from producers would be temporarily stored in a message queue, which the broker processes, sending messages from the queue to the consumers.
  - Message queues allow better fault tolerance and scalability. As messages are stored in the queue until they are taken from the queue the failure of consumers does not lead to lost messages. Instead, in the case of a failure in a consumer, messages can be stored in the queue until the consumer can again process messages.

- Example: Rabbitmq

  > [RabbitMQ Tutorials — RabbitMQ](https://www.rabbitmq.com/getstarted.html)
  >
  > [amqp@v0.23.1 | Deno](https://deno.land/x/amqp@v0.23.1)

- Example: Redis

  > [Node Redis](https://redis.js.org/)



## 11 Production Configuration



### 11.1 Docker and Docker Compose

- `/items-api/Dockerfile.prod`

  ```dockerfile
  FROM denoland/deno:alpine-1.37.0
  
  EXPOSE 7777
  
  WORKDIR /app
  
  COPY deps.js .
  
  RUN deno cache deps.js
  
  COPY . .
  
  CMD [ "run", "--unstable", "--allow-net", "--allow-env", "app.js" ]
  ```

- `docker-compose.prod.yml`

  ```yaml
  # ..
    items-api:
      build: 
        context: items-api
        dockerfile: Dockerfile.prod
      image: items-api-prod
      restart: "on-failure"
      expose:
        - 7777
      depends_on:
        - database
        - flyway
        - redis
      env_file:
        - project.env
      deploy:
        replicas: 2
        restart_policy:
          condition: on-failure
          delay: "5s"
          max_attempts: 5
          window: "30s"
  # ...
  
  # ... 
    database:
      container_name: database-server
      image: postgres:14.1
      restart: unless-stopped
      volumes:
        - ./production-database-data:/var/lib/postgresql/data
      env_file:
        - project.env
  # ...
  ```

  

### 11.2 Astro production build

- `/items-ui/Dockerfile.prod`

  ```dockerfile
  FROM node:lts-alpine3.17 as build
  
  WORKDIR /app
  
  ENV PATH /app/node_modules/.bin:$PATH
  
  COPY *.json ./
  
  RUN npm install
  
  COPY . .
  
  RUN astro build
  
  FROM nginx:latest as server
  
  EXPOSE 3000
  
  RUN sed -i "s/80/3000/g" /etc/nginx/conf.d/default.conf
  
  COPY --from=build /app/dist /usr/share/nginx/html
  
  CMD ["nginx", "-g", "daemon off;"]
  ```

- `docker-compose.prod.yml`
  ```yaml
  # ...
    items-ui:
      build: 
        context: items-ui
        dockerfile: Dockerfile.prod
      image: items-ui-prod
      restart: "on-failure"
      ports:
        - 3000:80
      depends_on:
        - items-api
      deploy:
        restart_policy:
          condition: on-failure
          delay: "5s"
          max_attempts: 5
          window: "30s"
  # ...    



### 11.3 NGINX trickery

- `/nginx/nginx.prod.conf`

  ```
  # ..
  
  http {
    proxy_cache_path /var/cache/nginx keys_zone=astro_ssg_cache:1m inactive=5m max_size=512m;
    # ..
  ```

  ```
      location /api/ {
        proxy_pass http://items-api/;
        add_header Cache-Control 'no-store';
      }
  ```

  ```
      location / {
        proxy_pass http://items-ui;
        proxy_cache astro_ssg_cache;
        proxy_cache_key $uri;
        proxy_cache_valid 5m;
      }
  ```

  ```
    server {
      gzip on;
      gzip_types text/css application/javascript application/json image/svg+xml;
      gzip_min_length 1000;
  
      # ...
  ```




> ```
> tree --dirsfirst
> .
> ├── flyway
> │   └── sql
> │       └── V1___initial_schema.sql
> ├── items-api
> │   ├── services
> │   │   └── itemService.js
> │   ├── util
> │   │   └── cacheUtil.js
> │   ├── app.js
> │   ├── deps.js
> │   ├── Dockerfile
> │   └── Dockerfile.prod
> ├── items-ui
> │   ├── public
> │   │   └── favicon.svg
> │   ├── src
> │   │   ├── pages
> │   │   │   └── index.astro
> │   │   └── env.d.ts
> │   ├── astro.config.mjs
> │   ├── package.json
> │   ├── package-lock.json
> │   ├── README.md
> │   ├── tsconfig.json
> │   ├── Dockerfile
> │   └── Dockerfile.prod
> ├── nginx
> │   ├── nginx.conf
> │   └── nginx.prod.conf
> ├── redis
> │   └── redis.conf
> ├── docker-compose.yml
> ├── docker-compose.prod.yml
> └── project.env
> ```





## 12 Content-Delivery Networks



### 12.1 HTTP limitations

- HTTP/1.0
  - With HTTP/1.0, a new TCP connection is needed for each request, requiring a TCP handshake for every request. 
- HTTP/1.1
  - With HTTP/1.1, there is the possibility to maintain the underlying TCP connection, leading to new requests being sent potentially over an existing connection. 
  - In addition, browsers can open up multiple connections per server, leading to parallel requests; resources can also be stored on separate servers
- HTTP/2
  - One of the improvements is to provide the server the opportunity for sending multiple resources as a part of the response to a request. This reduces the time spent in opening and closing the connections, and also potentially reduces the time that loading a site takes. 
  - The HTTP/2 protocol includes also other improvements, most of the improvements are implemented on the servers that run web applications, not web applications per se.
- HTTP/3
  - The third version of the HTTP-protocol, HTTP/3 (Proposed Standard), attempts to improve the functionality of dynamic web sites. For example, while HTTP/1 and HTTP/2 use the TCP-protocol, which tries to ensure that messages are received, HTTP/3 will work over UDP-protocol. As the UDP protocol, which is often used e.g. in video games, does not try to ensure that messages will be received, a protocol called QUIC is used on top of it to handle data loss

- Head-of-line blocking
  - An issue that arises when one request blocks others from being processed due to a lack of available connections
  - With HTTP/2 that allows multiplexing, i.e. sending multiple requests at the same time over a single connection, a high number of requests will not create a similar performance hit as it did with HTTP/1.0 or HTTP/1.1.



### 12.2 Content-delivery networks

- Conception
  - Content-delivery networks are networks of servers used for distributing (primarily) static content.
  - Content-delivery networks can be seen as a shared cache, where cacheable data (static website content) is distributed across servers. These servers typically have a range of hostnames, which differ from the host of the web server(s) responsible for serving dynamic content. The range of hostnames allow browsers to open up more connections for requesting content, avoiding the limitations on persistent open connections
- Strategies
  - In practice, when a CDN is used, the response from a server links resources to external addresses, which the browser then retrieves.
  - An alternative option would be to give the CDN provider the control over name servers of the web application domain, which would allow proxying requests over the CDN. In such a case, specific paths of the application could be configured to be handled by the CDN, while other parts could be directed to the web application.

- Flaws
  - Similar to caching in web applications, CDNs also suffer from issues such as stale cache and can even open create vulnerabilities. 
  - As an example, if the static resources served through CDNs include code executed on the client (as is often the case), a malicious user could influence data on the CDN, leading to loading vulnerable client-side code on the client. 
  - In a similar fashion, CDNs could be used for e.g. denial of service attacks





## 13 Data and Scalability



### 13.1 Database as a bottleneck

- In web applications, the database is often a large contributor to the perceived performance, as it is a separate system that needs to be queried on demand.
- When we consider a simple database, there are a handful of approaches that can be taken to improve performance:
  - caching database query results to avoid re-reading data that hasn't changed
  - designing and applying meaningful database indexes to allow faster searching of information
  - data denormalization to avoid expensive joins
  - table partitioning. 



### 13.2 Database indexes

- Create indexes
  ```postgresql
  CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
  );
  
  CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
  );
  
  CREATE TABLE users_to_items (
    user_id INTEGER NOT NULL REFERENCES users(id),
    item_id INTEGER NOT NULL REFERENCES items(id)
  );
  
  CREATE INDEX idx_users_name ON users(name);
  
  CREATE INDEX idx_users_to_items ON users_to_items (user_id, item_id);
  ```

- EXPLAIN

  - The EXPLAIN command can be used to see the query plan of a database query. It will highlight if queries tables are looked into using a sequential scan, and whether there are any indexes at play.

  



### 13.3 ACID, CAP, and BASE

- ACID
  - Transactional database systems isolate activities of individual users from all other concurrently happening activities, limiting the duration and degree of the isolation. 
  - In transactional database systems, queries that belong to transaction should be either completed fully or not completed at all, and changes occurring during a transaction should not influence other concurrently executed queries. 
  - Four properties -- the acronym ACID -- highlight the quality of a transactional database system.
    - Atomicity -- a database that offers atomicity must guarantee that each transaction must complete fully or not complete at all, and the user must be made aware of whether the transaction was completed (or not).
    - Consistency -- a database that offers consistency must guarantee that the results of a transaction that completes fully are committed (and stored) to the database.
    - Isolation -- a database that offers isolation must hide events within a transaction from other concurrently running transactions, which allows resetting a failed transaction to the initial state, as required by Atomicity.
    - Durability -- a database that offers durability must guarantee that the committed results survive malfunctions.
- CAP
  - When we consider scalable web applications that eventually will become distributed, maintaining consistency becomes challenging as networks can have partitions -- i.e., there are breaks in networks where parts of a network are isolated from others. 
  - Due to this, when designing a distributed database application, tradeoffs between availability of the database application and the correctness of the data in the database are involved.
  - The CAP Principle (also CAP Theorem) highlights that distributed systems can have only two out of the following three properties:
    - Strong Consistency -- a distributed system with strong consistency can guarantee that the results of a transaction that completes fully are committed and stored to the database (in the same vein as Consistency in ACID).
    - High Availability -- a distributed system with high availabity uses redundancy and data replication, leading to a situation where at least some replica of data can be reached even in the case of network partitions.
    - Partition-resilience -- a distributed system with partition resilience can survive even in the case of (network) partitions between the data replicas.
- BASE
  - While the acronym ACID provides a set of principles that are required for a transactional database system, the acronym BASE provides a set of principles for designing distributed database system. BASE stands for Basically Available, Soft state, Eventually consistent
    - Basically Available -- a distributed system with basic availability distributes data and accepts failures, which means that at least some users will get data.
    - Soft state -- a distributed system with soft state can lose state information, e.g., in the case of system crashes or network issues.
    - Eventually consistent -- a distributed system with eventual consistency guarantees that data will be consistent at some point in time.



### 13.4 Distributing database data

- Data replication
  - In data replication, the database data is replicated over a number of servers, each maintaining a copy of the data. This can improve availability and fault tolerance, as a failure of one server does not result in the loss of data. However, it also requires that the data is updated between the servers to maintain consistency.
  - When using data replication, effort to maintain data consistency is required.
  - There are two key approaches to updating data between servers: 
    - primary-secondary replication
      - In primary-secondary replication, one server is the primary, which is responsible for writing data, and the other servers are secondary, which are responsible for reading data.
    - primary-primary replication.  
      - In primary-primary replication, all servers are primaries, and all servers are responsible for both writing and reading data.
- Data sharding
  - In data sharding, the database data is divided into shards that are stored in two or more servers, each maintaining its own data shard. As each server is responsible for its own shard, there is consistency in place. Sharding can improve performance, as queries requiring data from a single server and shard can be faster when contrasted to a single server with all the data. At the same time, queries requiring data from multiple shards can be slower, as data needs to be retrieved from multiple servers.
  - When using data sharding, additional effort is required to maintain fault tolerance. If a server responsible for a shard goes down, that shard is not available.
  - Data sharding also needs a mechanism to identify which shard to use for a given query. This is achieved, for example, by using a hash function or a distributing data to database based on a range of values. 





## 14 Container Orchestration



### 14.1 Container orchestration

- Challenge
  - To handle a crashed container or to increase the number or replicas, a classic approach would be to manually restart the container (or to use a restart policy) and to manually adjust the number of replicas in the application. 
  - However, this approach is not scalable, as it requires manual intervention.

- Conception
  - The term orchestration refers to the automated configuration, coordination, and management of computer systems and software. 
  - In the context of containers, the term refers to automating deployment, management, scaling, and networking of containers -- essentially **managing the lifecycle of the containers**. 
  - The automation becomes necessary with the increasing amount of containers (e.g. through the use of microservices), as well as from the increasing complexity of the containerized applications; orchestration tools help in managing the complexity.
  - There are a handful of container orchestration implementations, including Kubernetes, Docker Swarm, and Apache Mesos.



### 14.2 Introduction to Kubernetes

- Conception
  - Kubernetes is one of the most popular container orchestration systems. It is used to manage the deployment and scaling of containerized applications. 
  - Initially founded and developed by Google, Kubernetes is open source and is presently developed and maintained by the Cloud Native Computing Foundation (CNCF).
  - When discussing Kubernetes applications, there are four key terms that are often used: (1) Container, (2) Pod, (3) Node, and (4) Cluster. These are as follows:

    - A container is a standard unit of software that packages up code and dependencies so that the the application can be transferred from one environment to another (hello Docker!).
    - A pod is the smallest deployable and creatable Kubernetes unit. A pod contains one or more (running) containers that can be managed with Kubernetes.
    - A node represents a worker machine, which can be a virtual machine or a physical machine, depending on the cluster configuration. Nodes contain functionality to run the pods and to handle networking.
    - A cluster is a set of nodes that is managed by Kubernetes.

- Setting up Minikube

  - Minikube

    - Minikube allows quickly setting up a local Kubernetes cluster that can be used for development and testing. It is available for Linux, macOS, and Windows.

  - Installation

    > [minikube start | minikube](https://minikube.sigs.k8s.io/docs/start/)

  - Usage

    - check version: `minikube version`
    - start a cluster:  `minikube start`
    - stop a cluster: `minikube stop`
    - delete a cluster: `minikube delete`

  - Kubectl

    - kubectl is a command-line tool for interacting with the Kubernetes cluster. 

      > [Install Tools | Kubernetes](https://kubernetes.io/docs/tasks/tools/)

- Building a Docker image for Minikube

  - build the image: `minikube image build -t my-app -f ./Dockerfile .`
  - check the image: `minikube image list`

- Deploy an application
  ```yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: my-app-deployment
    labels:
      app: my-app
  spec:
    selector:
      matchLabels:
        app: my-app
    template:
      metadata:
        labels:
          app: my-app
      spec:
        containers:
          - name: my-app
            image: my-app:latest
            imagePullPolicy: Never
            ports:
              - containerPort: 7777
  ---
  apiVersion: v1
  kind: Service
  metadata:
    name: my-app-service
  spec:
    type: LoadBalancer
    ports:
      - port: 7777
        targetPort: 7777
        protocol: TCP
    selector:
      app: my-app
  ```

  - deploy: `kubectl apply -f kubernetes/my-app-deployment.yaml `
  - check the deployment: `kubectl get deployments` / `kubectl get pods`
  - check the service: `kubectl get services`

- Access the app

  - expose the service: `minikube service my-app-service --url`
  - forward the port: `kubectl port-forward svc/my-app-service 7800:7800`



### 14.3 Scaling with Kubernetes

- Kubernetes control plane
  - We interact with the Kubernetes control plane when using kubectl.
  - Kubernetes control plane is an orchestration layer of a Kubernetes cluster that consists of a set of processes that are responsible for managing the cluster. 
  - The control plane has a distributed key-value store ectd, a scheduler, two controller managers, and an API server (which kubectl interacts with).
  - The control plane manages nodes in the cluster and interacts with them. The interaction is handled through kubelet and kube-proxy that are processes running on each node. 
    - The **kubelet** is responsible for managing the containers
    - The kube-proxy handles the networking.

- Metrics and resources

  - Available resources

    - By default, Minikube starts as a docker container with default CPU limit set to 2
    - set CPU limit: `minikube start --cpus 4`

  - Enabling metrics server

    - enable: `minikube addonds enable metrics-server`

    - check: `minikube addons list` / `kubectl get pods -n kube-system`

      > The command `kubectl get pods -n kube-system` lists all pods in the kube-system namespace, which is used for Kubernetes system components.

  - Defining resource requests
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my-app-deployment
      labels:
        app: my-app
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
            - name: my-app
              image: my-app:latest
              imagePullPolicy: Never
              ports:
                - containerPort: 7777
              resources:
                requests: 
                  cpu: 100m
                limits: 
                  cpu: 200m
    ```

    - check resource usage: `kubectl top pods`

- Scaling applications automatically

  ```yaml
  # ...
  ---
  apiVersion: autoscaling/v1
  kind: HorizontalPodAutoscaler
  metadata:
    name: my-app-deployment-hpa
  spec:
    scaleTargetRef:
      apiVersion: apps/v1
      kind: Deployment
      name: my-app-deployment
    minReplicas: 1
    maxReplicas: 5
    targetCPUUtilizationPercentage: 10
  ```

  - check: `kubectl get hpa`

- Scaling databases

  - Kubernetes operators

    - Kubernetes operators are Kubernetes extensions that work with custom resources to manage applications. They allow automating configuration, deployment, and maintenance of software, and in general help in defining deployable software components for Kubernetes.
    - There exists a variety of Kubernetes operators for setting up databases. As an example, for PostgreSQL, there exists multiple operators, including the CloudNativePG, Zalando's Postgres Operator, Kubegres, Stolon, and Crunchy Data's PGO. Similarly, for e.g. Redis, there exists a handful of options to choose from, including the official (non-free) Redis Enterprise version, Spotahome's redis operator, and a redis operator from Opstree solutions.

  - Using a PostgreSQL operator

    - install CloudNativePG: `kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.19/releases/cnpg-1.19.1.yaml`

      - check: `kubectl get all -n cnpg-system`

    - deploying a cluster: 
      ```yaml
      apiVersion: postgresql.cnpg.io/v1
      kind: Cluster
      metadata:
        name: my-app-database-cluster
      spec:
        instances: 2
        storage:
          size: 64Mi
      ```

      - apply: `kubectl apply -f kubernetes/my-app-database-cluster.yaml `
      - check:  `kubectl get cluster`

    - peeking into the database 

      - check the status: `kubectl cnpg status my-app-database-cluster`
      - connect: `kubectl cnpg psql my-app-database-cluster`

      > cnpg plugin for kubectl: [Kubectl Plugin - CloudNativePG](https://cloudnative-pg.io/documentation/1.21/kubectl-plugin/#generation-of-installation-manifests)

  - Database migrations

    - build migration job image

      ```dockerfile
      # /flyway/Dockerfile
      FROM flyway/flyway:9.8.3-alpine
      
      # Assuming we're building the image inside the `flyway` -folder
      COPY sql/ /flyway/sql/
      
      # Use shell form for entrypoint to get access to env variables
      ENTRYPOINT ./flyway migrate -user=$FLYWAY_USER -password=$FLYWAY_PASSWORD -url="jdbc:postgresql://${MY_APP_DATABASE_CLUSTER_RW_SERVICE_HOST}:${MY_APP_DATABASE_CLUSTER_RW_SERVICE_PORT}/${FLYWAY_USER}"
      ```

      - build image: `minikube image build -t my-app-database-migrations -f ./Dockerfile .`

    - flyway Job configuration
      ```yaml
      apiVersion: batch/v1
      kind: Job
      metadata:
        name: my-app-database-migration-job
      spec:
        template:
          metadata:
            name: my-app-database-migration-job
          spec:
            containers:
              - name: my-app-database-migrations
                image: my-app-database-migrations:latest
                imagePullPolicy: Never
                env:
                  - name: FLYWAY_USER
                    valueFrom:
                      secretKeyRef:
                        name: my-app-database-cluster-app
                        key: username
                        optional: false
                  - name: FLYWAY_PASSWORD
                    valueFrom:
                      secretKeyRef:
                        name: my-app-database-cluster-app
                        key: password
                        optional: false
            restartPolicy: Never
        backoffLimit: 2
      ```

  - Connecting to the database

    - deployment configuration
      ```yaml
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: my-app-deployment
        labels:
          app: my-app
      spec:
        selector:
          matchLabels:
            app: my-app
        template:
          metadata:
            labels:
              app: my-app
          spec:
            containers:
              - name: my-app
                image: my-app:latest
                imagePullPolicy: Never
                ports:
                  - containerPort: 7777
                resources:
                  requests: 
                    cpu: 100m
                  limits: 
                    cpu: 200m
                env:
                  - name: PGPASS
                    valueFrom:
                      secretKeyRef:
                        name: my-app-database-cluster-app
                        key: pgpass
                        optional: false
      ```

    - connection
      ```javascript
      import { postgres } from "./deps.js";
      const PGPASS = Deno.env.get("PGPASS").trim();
      const PGPASS_PARTS = PGPASS.split(":");
      
      const host = PGPASS_PARTS[0];
      const port = PGPASS_PARTS[1];
      const database = PGPASS_PARTS[2];
      const username = PGPASS_PARTS[3];
      const password = PGPASS_PARTS[4];
      
      const sql = postgres({
        host,
        port,
        database,
        username,
        password,
      });
      
      export { sql }
      ```





## 15 Monitoring Applications



### 15.1 Monitoring options

- Monitoring the infrastructure

  - Monitoring infrastructure involves monitoring both **the hardware and the software** that the application runs on. 

  - When monitoring hardware, we look into the CPU, memory, and disk usage

  - When monitoring software, we look into the operating system, the web server, the database, and the network. 

  - Kubernetes comes with a Dashboard that can be used to monitor the cluster resources. The dashboard is already included in Minikube: `minikube dashboard`

    > Monitor cluster with Grafana and/or Prometheus,: [Quickstart - CloudNativePG](https://cloudnative-pg.io/documentation/1.19/quickstart/#part-4-monitor-clusters-with-prometheus-and-grafana)

- Monitoring the server-side application

  - When monitoring the server-side application, we are looking into the behavior of the code running on the server (and into potential lacks in running the code). 
  - Here, aspects such as the response times of the server, the database, and the code running on the server itself can be monitored. 
  - Both **Grafana and Prometheus** provide means for this through their plugins: [Monitor Kubernetes cluster performance with the Prometheus operator](https://grafana.com/blog/2023/01/19/how-to-monitor-kubernetes-clusters-with-the-prometheus-operator/)

- Monitoring the client-side application

  - A crucial part in monitoring a web application is also monitoring the client-side application (i.e. the code that is running on the client). 
  - This allows catching errors on the client, monitoring the performance of the application on the client, and so on,
  - could be achieved e.g. with Sentry, which is a service for monitoring and tracking errors in client-side applications.

- Monitoring the user flow

  - It is also important to monitor the user flow to identify potential issues in the application design. As an example, if the majority of the users do not complete specific flows such as registration or logging in, there might be something to improve in the application design.
  - Perhaps the most commonly used tool for this is Google Analytics, which allows monitoring the user flow of a web application. There are also plenty of alternatives, including hotjar and Matomo analytics.