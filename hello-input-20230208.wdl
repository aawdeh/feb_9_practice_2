#specifity version of wdl 
version 1.0

#define workflow 
workflow HelloInput {
  input {
    #define string to pass along to other tasks 
    String name_input 
  }
  #call to do work -- calls task 
  call WriteGreeting {
    input:
      #does this have to be the same name as the inputs in the task 
      name_for_greeting = name_input 
  }
  
  #workflow output section 
  output {
    File final_output = WriteGreeting.greeting_output 
      
  }
}

#a hello world wdl takes in user defined input and outputs that 
#define task section
task WriteGreeting {
  input {
   #you can hard code by saying name_of_greeting = "Aseel"
   String name_for_greeting 
  }
  
  #use angled brackets instead of { however { can still be used
  command <<<
    #where using a ubunuto docker so we can use bash commands
    echo 'hello ~{name_for_greeting}!' > greeting.txt
  >>>
  
  output {
   #if greeting_output/greeting.txt not defined here it will disapper once task ends
   File greeting_output = "greeting.txt" 
  }
  
  #define docker that you would like the workflow to use
  #does it do the docker pull command for you? 
  runtime {
  	docker: "ubuntu:latest"
  }
}
