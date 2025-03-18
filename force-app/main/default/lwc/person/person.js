import { LightningElement, track,api } from 'lwc';

export default class Person extends LightningElement 
{
    @api location;
    @track
    person = {
        FirstName: 'suman',
        LastName: 'reddy'
    }
    // @track --> when ever you want to make a property of data member reactive
    // @api --> if you want make variable/function public then we can use @api decorator
    // Note: if you are updating whole data no need to use tracker, if you are updating
    // property of the data member you can use @track
    
    @api
    updateUser()
    {
        // this.person = {
        //     FirstName: "kavin",
        //     LastName :"kumar"
        // }
        this.person.FirstName = 'kavin12';
        console.log('child method called');
    }
}