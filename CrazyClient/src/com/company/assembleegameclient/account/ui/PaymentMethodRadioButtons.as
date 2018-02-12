﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.account.ui.PaymentMethodRadioButtons

package com.company.assembleegameclient.account.ui
{
    import flash.display.Sprite;
    import kabam.rotmg.ui.view.SignalWaiter;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.account.ui.components.SelectionGroup;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.account.ui.components.Selectable;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import kabam.lib.ui.impl.HorizontalLayout;
    import kabam.lib.ui.api.Layout;
    import __AS3__.vec.*;

    public class PaymentMethodRadioButtons extends Sprite 
    {

        private const waiter:SignalWaiter = new SignalWaiter();

        private var labels:Vector.<String>;
        private var boxes:Vector.<PaymentMethodRadioButton>;
        private var group:SelectionGroup;

        public function PaymentMethodRadioButtons(_arg_1:Vector.<String>)
        {
            this.labels = _arg_1;
            this.waiter.complete.add(this.alignRadioButtons);
            this.makeRadioButtons();
            this.alignRadioButtons();
            this.makeSelectionGroup();
        }

        public function setSelected(_arg_1:String):void
        {
            this.group.setSelected(_arg_1);
        }

        public function getSelected():String
        {
            return (this.group.getSelected().getValue());
        }

        private function makeRadioButtons():void
        {
            var _local_1:int;
            var _local_2:int = this.labels.length;
            this.boxes = new Vector.<PaymentMethodRadioButton>(_local_2, true);
            while (_local_1 < _local_2)
            {
                this.boxes[_local_1] = this.makeRadioButton(this.labels[_local_1]);
                _local_1++;
            };
        }

        private function makeRadioButton(_arg_1:String):PaymentMethodRadioButton
        {
            var _local_2:PaymentMethodRadioButton = new PaymentMethodRadioButton(_arg_1);
            _local_2.addEventListener(MouseEvent.CLICK, this.onSelected);
            this.waiter.push(_local_2.textSet);
            addChild(_local_2);
            return (_local_2);
        }

        private function onSelected(_arg_1:Event):void
        {
            var _local_2:Selectable = (_arg_1.currentTarget as Selectable);
            this.group.setSelected(_local_2.getValue());
        }

        private function alignRadioButtons():void
        {
            var _local_1:Vector.<DisplayObject> = this.castBoxesToDisplayObjects();
            var _local_2:Layout = new HorizontalLayout();
            _local_2.setPadding(20);
            _local_2.layout(_local_1);
        }

        private function castBoxesToDisplayObjects():Vector.<DisplayObject>
        {
            var _local_1:int;
            var _local_2:int = this.boxes.length;
            var _local_3:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
            while (_local_1 < _local_2)
            {
                _local_3[_local_1] = this.boxes[_local_1];
                _local_1++;
            };
            return (_local_3);
        }

        private function makeSelectionGroup():void
        {
            var _local_1:Vector.<Selectable> = this.castBoxesToSelectables();
            this.group = new SelectionGroup(_local_1);
            this.group.setSelected(this.boxes[0].getValue());
        }

        private function castBoxesToSelectables():Vector.<Selectable>
        {
            var _local_1:int;
            var _local_2:int = this.boxes.length;
            var _local_3:Vector.<Selectable> = new Vector.<Selectable>(0);
            while (_local_1 < _local_2)
            {
                _local_3[_local_1] = this.boxes[_local_1];
                _local_1++;
            };
            return (_local_3);
        }


    }
}//package com.company.assembleegameclient.account.ui
