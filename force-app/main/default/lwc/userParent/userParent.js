import { LightningElement } from 'lwc';

export default class UserParent extends LightningElement 
{
     isMyUser = false;
     updateUser()
     {
        console.log('parent method called');
        this.template.querySelector('c-user').updateUser();
     }
}