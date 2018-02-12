﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.stage3D.Object3D.OBJGroup

package kabam.rotmg.stage3D.Object3D
{
    import flash.display3D.IndexBuffer3D;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class OBJGroup 
    {

        public var name:String;
        public var materialName:String;
        public var indexBuffer:IndexBuffer3D;
        public var _faces:Vector.<Vector.<String>>;
        public var _indices:Vector.<uint>;

        public function OBJGroup(_arg_1:String=null, _arg_2:String=null)
        {
            this.name = _arg_1;
            this.materialName = _arg_2;
            this._faces = new Vector.<Vector.<String>>();
            this._indices = new Vector.<uint>();
        }

        public function dispose():void
        {
            if (this.indexBuffer != null)
            {
                this.indexBuffer.dispose();
                this.indexBuffer = null;
            };
            this._faces.length = 0;
            this._indices.length = 0;
        }


    }
}//package kabam.rotmg.stage3D.Object3D
