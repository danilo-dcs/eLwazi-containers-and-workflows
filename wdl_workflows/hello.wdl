version 1.0

workflow hellowdl {
   String greetings = "Hello world"

   call helloworld {
     input:
       hello_in = greetings
   }

   output {
    File out_workflow = helloworld.hello_out
   }
}

task helloworld {
   input {
     String hello_in
   }

   command {
     echo ~{hello_in} > hello.txt
   }

   output {
     File hello_out = "hello.txt"
   }
}
