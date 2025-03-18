import { api, LightningElement, track } from 'lwc';

export default class User extends LightningElement 
{
    @track
    user = {
        FirstName: "suman",
        LastName: "reddy"
    }
    @api
    ismyuser;
    @api 
    updateUser()
    {
        console.log('function called');
        // this.user = {
        //     FirstName: "pavan",
        //     LastName: "kumar"
        // }
        this.user.FirstName = 'pavan';
    }

}