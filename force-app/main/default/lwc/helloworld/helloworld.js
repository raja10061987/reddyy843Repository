import { LightningElement } from 'lwc';

export default class Helloworld extends LightningElement 
{
    title='this is mytitle';
    handleclick()
    {
        var myvar = 'inside button';
        this.title = 'title is changed inside the method';
    }

}