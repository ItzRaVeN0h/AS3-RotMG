﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.ServerBoxes

package com.company.assembleegameclient.screens
{
    import flash.display.Sprite;
    import __AS3__.vec.Vector;
    import kabam.rotmg.servers.api.Server;
    import flash.events.MouseEvent;
    import com.company.assembleegameclient.parameters.Parameters;
    import __AS3__.vec.*;

    public class ServerBoxes extends Sprite 
    {

        private var boxes_:Vector.<ServerBox> = new Vector.<ServerBox>();

        public function ServerBoxes(_arg_1:Vector.<Server>)
        {
            var _local_2:ServerBox;
            var _local_3:int;
            var _local_4:Server;
            super();
            _local_2 = new ServerBox(null);
            _local_2.setSelected(true);
            _local_2.x = ((ServerBox.WIDTH / 2) + ((Parameters.data_.showHackOptions) ? -(ServerBox.WIDTH / 2) : 2));
            _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            addChild(_local_2);
            this.boxes_.push(_local_2);
            _local_3 = 2;
            for each (_local_4 in _arg_1)
            {
                if ((Parameters.data_.showHackOptions) && _local_4.name == "Proxy")
                {
                    _local_2 = new ServerBox(_local_4);
                    if (_local_4.name == Parameters.data_.preferredServer)
                    {
                        this.setSelected(_local_2);
                    };
                    _local_2.x = ((ServerBox.WIDTH) + 4);
                    _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                    addChild(_local_2);
                    this.boxes_.push(_local_2);
                }
                else
                {
                    _local_2 = new ServerBox(_local_4);
                    if (_local_4.name == Parameters.data_.preferredServer)
                    {
                        this.setSelected(_local_2);
                    };
                    _local_2.x = ((_local_3 % 2) * (ServerBox.WIDTH + 4));
                    _local_2.y = (int((_local_3 / 2)) * (ServerBox.HEIGHT + 4));
                    _local_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                    addChild(_local_2);
                    this.boxes_.push(_local_2);
                    _local_3++;
                };
            };
        }

        private function onMouseDown(_arg_1:MouseEvent):void
        {
            var _local_2:ServerBox = (_arg_1.currentTarget as ServerBox);
            if (_local_2 == null)
            {
                return;
            };
            this.setSelected(_local_2);
            Parameters.data_.preferredServer = _local_2.value_;
            Parameters.save();
        }

        private function setSelected(_arg_1:ServerBox):void
        {
            var _local_2:ServerBox;
            for each (_local_2 in this.boxes_)
            {
                _local_2.setSelected(false);
            };
            _arg_1.setSelected(true);
        }


    }
}//package com.company.assembleegameclient.screens
