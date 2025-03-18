import { LightningElement } from 'lwc';

export default class PersonList extends LightningElement {
    persons = [
        {
          id: 1,
          name:'raja1'
        },
        {
          id: 2,
          name:'raja2'

        },
        {
            id: 3,
            name:'raja3'
        },
        {
            id: 4,
            name:'raja4'
        },
        {
            id: 5,
            name:'suman'
        }
    ];
}