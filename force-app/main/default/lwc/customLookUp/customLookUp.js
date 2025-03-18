import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountSearchController.getAccounts';

export default class CustomLookUp extends LightningElement {
    accountName = '';
    @track accountList = [];
    objectApiName = 'Account';
    accountId;
    isShow = false;
    messageResult = false;
    isShowResult = false;
    showSearchedValues = false;

    @wire(getAccounts, { actName: '$accountName' })
    retriveAccounts({ error, data }) {
        if (data) {
            console.log('data length: ' + data.length);
            this.accountList = [];
            if (data.length > 0 && this.isShowResult) {
                this.accountList = data;
                this.showSearchedValues = true;
                this.messageResult = false;
            }
            else if (data.length == 0) {
                this.accountList = [];
                this.showSearchedValues = false;
                if (this.accountName != '') {
                    this.messageResult = true;
                }
            }

        }
        else if (error) {
            this.accountId = '';
            this.accountName = '';
            this.accountList = [];
            this.showSearchedValues = false;
            this.messageResult = true;
        }

    }
    handleClick(event) {
        this.isShowResult = true;
        this.messageResult = false;
    }
    handleKeyChange(event) {
        this.messageResult = false;
        this.accountName = event.target.value;
        console.log('accountName: ' + this.accountName);
    }

    handleParentSelection(event) {
        this.showSearchedValues = false;
        this.isShowResult = false;
        this.messageResult = false;
        this.accountId = event.target.dataset.value;
        this.accountName = event.target.dataset.label;
        console.log('accountId: ' + this.accountId + '  accountName: ' + this.accountName);
        const custEvent = new CustomEvent('selected', { detail: this.accountId });
        this.dispatchEvent(custEvent);
    }

    handleOpenModal(event) {
        this.isShow = true;

    }

    handleCloseModal(event) {
        this.isShow = false;
    }
    handleSuccess(event) {
        console.log('newly created account record id: ' + event.detail.id);
        this.isShowResult = false;
        this.messageResult = false;
        this.isShow = false;
        this.accountId = event.detail.id;
        this.accountName = event.detail.fields.Name.value;
        const selectedEvent = new CustomEvent('selected', { detail: this.accountId });
        this.dispatchEvent(selectedEvent);

    }
    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                console.log('each field: ' + field.value + 'fieldName: ' + field.Name);
                // field.value = null;
                field.reset();
            });
        }
        this.isShow = false;
    }
}