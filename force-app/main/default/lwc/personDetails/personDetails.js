import { LightningElement } from 'lwc';

export default class PersonDetails extends LightningElement {
    name = 'rajasekhar';
    description = 'CEO of the company';
    showDetails = false;
    actionButtonLabel = 'show details';
    toggleDetails()
    {
        this.showDetails = !this.showDetails;
        this.actionButtonLabel = this.showDetails ? 'hide Details': 'show Details';
        console.log('showDetails flag value: ' + this.showDetails);

    }
}