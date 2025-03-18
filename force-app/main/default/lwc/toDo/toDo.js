import { LightningElement, track,wire } from 'lwc';
import getTasks from '@salesforce/apex/toDoListController.getTasks';
import {refreshApex} from '@salesforce/apex';
import insertTask from '@salesforce/apex/toDoListController.insertTask';
import deleteTask from '@salesforce/apex/toDoListController.deleteTask';

export default class ToDo extends LightningElement 
{
    @track todoTasks = [];
    @track error = '';
    @track toDoTaskResponse = '';
    @track newTask = '';
    @track todoTasksSize = '';
    processing = true;
                               
         @wire(getTasks)
         getTodoTasks(response)
         {
          
          if(response && response.data)
          {
            this.toDoTaskResponse = response;
            this.todoTasks = []; // nullifying the todoTasks
           response.data.forEach(task => {
                this.todoTasks.push({
                  id: this.todoTasks.length + 1,
                  name: task.Subject,
                  recordId: task.Id
            }); 
        });

          this.todoTasksSize = this.todoTasks.length;
       }
      else if(response && response.error)
      {
         let error = response.error;
          console.log('error: ' + error);
       }
       this.processing = false;
    }

    updateNewTask(event)
    {
      this.newTask = event.target.value;
     
    }
    addNewTask(event)
    {
      if(this.newTask == '')
      {
         return;
      }
      this.processing = true;
       insertTask({subject: this.newTask})
       .then(result => {
        // console.log('New task inserted: ' + result);
         // push method is used for to insert the elements at the end of the array
        // unshift method is uesed for to insert the new element at the begining of the arraey
         this.todoTasks.push({
          id: this.todoTasks[this.todoTasks.length - 1] ? this.todoTasks[this.todoTasks.length - 1].id + 1: 0,
          name: result.Subject,recordId: result.Id});
         this.todoTasksSize = this.todoTasks.length;
       })
       .catch(error => {
         console.log('error occured while inserting New Task: ' + error);
       })
       .finally(() => {
         this.processing = false;
         console.log('tododoTasks Insert: ' + JSON.stringify(this.todoTasks));
       })  
       this.newTask = '';
       
    }
    deleteTaskFromList(event)
    {
        let idToDelete = event.target.name;
        let todoTasks = this.todoTasks;
        let indexPosition = '';
        let recordIdToDelete = '';
        this.processing = true;
        for(let i = 0; i < todoTasks.length; i++)
        {
            if(idToDelete == todoTasks[i].id)
            {
              indexPosition = i;
            }

        }
          recordIdToDelete = todoTasks[indexPosition].recordId;

          deleteTask({recordId:recordIdToDelete})
          .then((result) => {
            if(result)
            {
            todoTasks.splice(indexPosition,1);
            }
            else {
              console.log('unable to delete');
            }
         
          this.todoTasksSize = todoTasks.length;
          })
          .catch((error) => {
            console.log('error: ' + error);
          })
          .finally(() => {
            this.processing = false;
            console.log('tododoTasks delete: ' + JSON.stringify(this.todoTasks));
          })



         

        // todoTasks.splice(
        //     todoTasks.findIndex(function(todoTask){
        //        return todoTask.id === idToDelete;
        //     })
        //     ,1);
        // todoTasks.splice(todoTasks.findIndex(todoTask => todoTask.id == idToDelete),1);

        
    }
   
    refreshTodoList()
    {
      this.processing = true;
      // it will refresh the browser cache, if only chnages are done server side
      refreshApex(this.toDoTaskResponse)
      .finally(() => {
        this.processing = false;
      })
      
    }
    
    // if you are binding the data to the variable using wire service,you can't update the wired data.
    // if you don't want update the wired data, you can bind the data to the variable/property directly
    //    @wire(getTasks) todoTasks; // wired variable is immutable, that menas you cannot add or delete the list items

    // @track todoTasks = {
    //    data: [
    //      {
    //       Id: '101',
    //       Subject: 'Task 1'
    //      },
    //      {
    //       Id: '102',
    //       Subject: 'Task 2'
    //      },
    //      {
    //       Id: '103',
    //       Subject: 'Task 3'
    //      }
         
    //    ],
    //    error: {}
    //  }
      
    
}