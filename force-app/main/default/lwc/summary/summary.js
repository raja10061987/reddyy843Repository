import { api, LightningElement } from 'lwc';

export default class Summary extends LightningElement 
{
    @api
    open = false;
    @api
    title = 'Summary Title';
    @api
    description= 'Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis risus eget urna mollis ornare vel eu leo. Nulla vitae elit libero, a pharetra augue.';

    get summaryIcon()
    {
        return this.open == false? 'utility:chevrondown':'utility:chevronright';    
    }
    toggleState()
    {
        this.open = !this.open;
        console.log('toggle state open value: ' + this.open);
    }
    get summaryClass()
    {
        return this.open? 'slds-summary-detail slds-is-open':'slds-summary-detail';
    }

}