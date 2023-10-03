version 1.0

workflow hellowdl {

   input {  # defining input (non static variables)
     String name = "Kat" 
   }

   String greetings = "Hello" # static variable

   # specifying the tasks that will run in this workflow
   call helloworld { 
     input:
       hello_in = greetings,
       name_in = name
   }

   call count {
     input:
       hello_in = helloworld.hello_out
   }

   output {
     File out_workflow = helloworld.hello_out
     File coun_txt_filet = count.count_txt
     Int count_int = count.count
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

task count {
   input {
     File hello_in
   }
   
   command <<<
     wc -m ~{hello_in} | awk '{print $1}' > count.txt
  
    >>>

   output {
     File count_txt = "count.txt"
     Int count = read_int("count.txt")
   }
}
