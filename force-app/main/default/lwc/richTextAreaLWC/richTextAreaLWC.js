import { LightningElement,api } from 'lwc';
import { FlowAttributeChangeEvent, FlowNavigationNextEvent, FlowNavigationFinishEvent, FlowNavigationBackEvent, FlowNavigationPauseEvent } from 'lightning/flowSupport';


export default class RichTextAreaLWC extends LightningElement 
{
    @api label;
    @api placeHolder;
    @api value;
    @api required = false;
    @api requiredMessage;

    @api availableActions = [];
    rendered = false;
    _validity = true;

    renderedCallback()
    {
        console.log('label: ' + this.label);
        console.log('placeHolder: ' + this.placeHolder);
        console.log('value: ' + this.value);
        console.log('required: ' + this.required);
        console.log('requiredMessage: ' + this.requiredMessage);
        if(this.rendered)
        {
            return;

        }
        this.rendered = true;

        if(this.required && !this.value)
        {
            let textArea = this.template.querySelector('lightning-input-rich-text');
            textArea.required = true;
        }

    }

    handleChange(event)
    {
        event.preventDefault();
        this.value = event.target.value;
        console.log('value: ' + this.value);
    }

    @api
    validate() {
        if(this.validateInput()) 
        { 
            return { isValid: true }; 
        } else { 
            return { isValid: false, errorMessage: this.requiredMessage }; 
        } 
    }

    
    validateInput(){
        if(!this.value){
            this._validity = false;
        }
        return this._validity;
    }

    @api
    handleGoNext() {
        if (this.availableActions.find(action => action === 'NEXT')) {
            const navigateNextEvent = new FlowNavigationNextEvent();
            console.log('handleGoNext called');
            this.dispatchEvent(navigateNextEvent);
        }
    }

    @api 
    handleGoFinish() {
        const navigateNextEvent = new FlowNavigationFinishEvent();
        console.log('handleGoFinish called');
        this.dispatchEvent(navigateNextEvent);
    }

    @api 
    handleGoBack() {
        const navigateNextEvent = new FlowNavigationBackEvent();
        console.log('handleGoBack called');
        this.dispatchEvent(navigateNextEvent);
    }
    @api 
    handleGoPause() {
        const navigateNextEvent = new FlowNavigationPauseEvent();
        console.log('handleGoPause called');
        alert('handleGoPause called');
        this.dispatchEvent(navigateNextEvent);
    }




}