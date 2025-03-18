import { LightningElement } from 'lwc';

export default class ColorPicker extends LightningElement 
{
    handleColorChange(event)
    {
        let colorValue = event.target.value;
        console.log('colorValue: ' + colorValue);
        const colorCodeEvent = new CustomEvent('colorChange',{detail:{colorValue}}); // create custom event
        this.dispatchEvent(colorCodeEvent); // fire event

    }
}