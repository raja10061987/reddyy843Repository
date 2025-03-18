import { LightningElement, track } from 'lwc';

export default class TrackPropertyExample extends LightningElement 
{
     greetings = 'Rajasekhar';
    handleData(event)
    {
        this.greetings = event.target.value;
        console.log('greeting changes: ' + this.greetings);

    }

}