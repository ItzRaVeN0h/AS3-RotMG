﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy

package kabam.rotmg.stage3D.proxies
{
    import flash.display3D.VertexBuffer3D;
    import __AS3__.vec.Vector;

    public class VertexBuffer3DProxy 
    {

        private var vertexBuffer3D:VertexBuffer3D;
        protected var data:Vector.<Number>;

        public function VertexBuffer3DProxy(_arg_1:VertexBuffer3D)
        {
            this.vertexBuffer3D = _arg_1;
        }

        public function uploadFromVector(_arg_1:Vector.<Number>, _arg_2:int, _arg_3:int):void
        {
            this.data = _arg_1;
            this.vertexBuffer3D.uploadFromVector(_arg_1, _arg_2, _arg_3);
        }

        public function getVertexBuffer3D():VertexBuffer3D
        {
            return (this.vertexBuffer3D);
        }

        public function getData():Vector.<Number>
        {
            return (this.data);
        }


    }
}//package kabam.rotmg.stage3D.proxies
