version 1.0

workflow hellowdl {

   input {  # defining input (non static variables)
     String name  
   }

   String greetings = "Hello" # static variable

   # specifying the tasks that will run in this workflow
   call helloworld { 
     input:
       hello_in = greetings,
       name_in = name
   }

   output {
    File out_workflow = helloworld.hello_out
   }
}

# declaring the tasks
task helloworld {
   input {
     String hello_in
     String name_in = "Jhon Doe"
   }

   command {
     echo ~{hello_in}~{name_in} > hello.txt
   }

   output {
     File hello_out = "hello.txt"
   }
}
