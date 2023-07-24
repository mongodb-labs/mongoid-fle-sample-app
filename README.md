# Sample Mongoid CSFLE Application

This is a sample application that demonstrates how to use 
the [Mongoid Client-Side Field Level Encryption](https://docs.mongodb.com/ruby-driver/master/tutorials/client-side-encryption/) 
feature with the [Mongoid ODM](https://docs.mongodb.com/mongoid/master/).

## Prerequisites

To use CSFLE with Mongoid, you must have the following:

* A MongoDB Atlas cluster running MongoDB 4.2 or later.
* MongoDB Ruby driver 2.13.0 or later.
* Mongoid 9.0.0 or later. This version is not released yet, so you must use the master branch of the Mongoid repository.
* The crypt_shared library. It can be downloaded from the [MongoDB Download Center](https://www.mongodb.com/try/download/enterprise).

## Getting Started

1. Clone this repository.
2. Install the dependencies:

   ```shell
   bundle install
   ```
   Please `libmongocrypt-helper` gem builds the library from sources, so you need to have `cmake` installed. 
   If you want to avoid building the library, you can download a pre-built version followin [these instructions](https://www.mongodb.com/docs/manual/core/csfle/reference/libmongocrypt/).
   If you decide to do so, you will need to set the `LIBMONGOCRYPT_PATH` environment variable to the path where you downloaded the library:
    
    ```shell
    export LIBMONGOCRYPT_PATH=<path to libmongocrypt>
    ```

3. Export the following environment variables :

   ```shell
   export ATLAS_URI=<your MongoDB Atlas connection string>
   export LOCAL_MASTER_KEY=<Random 96-byte string>
   ```
4. Create your first data key:

   ```shell
   rails db:mongoid:encryption:create_data_key
   ```
5. Export the id of the data key as an environment variable:

   ```shell
   export USER_KEY_ID=<your data key id>
   ```
   
6. Seed the database:

   ```shell
   rails db:seed
   ```
   
7. Run the application:

   ```shell
   rails server
   ```
   
The seeds includes two users: 'jane@doe.com' and 'john@doe.com', both with password '111111'. You can log in with either of them.
