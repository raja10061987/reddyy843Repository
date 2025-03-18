import { LightningElement, track } from 'lwc';

export default class PersonParent extends LightningElement {
    @track myElement;
    updateUser()
    {
        console.log('update user from parent method called');
        this.template.querySelector('c-person').updateUser();
    }
}