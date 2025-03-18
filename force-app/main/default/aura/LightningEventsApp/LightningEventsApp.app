<aura:application extends="force:slds">
    <aura:attribute name="totalIncome" type="decimal"></aura:attribute>
    <aura:handler name="totalIncomeComponentEvent" event="c:myLightningComonentEvent" action="{!c.handletotalIncome}"></aura:handler>
    outer component
    <div class="innerComponent">
        inner component section begin
         <c:LightningEventsCompContainer/>
        inner component section end
    </div>
    <span class="totalIncome">total Income: {!v.totalIncome}</span>
   
</aura:application>