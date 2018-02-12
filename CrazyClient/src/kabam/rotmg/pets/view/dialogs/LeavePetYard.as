﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.pets.view.dialogs.LeavePetYard

package kabam.rotmg.pets.view.dialogs
{
    import com.company.assembleegameclient.game.GameSprite;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.ui.dialogs.Dialog;
    import flash.events.Event;

    public class LeavePetYard extends PetDialog 
    {

        private var gameSprite:GameSprite;
        private var closeDialogSignal:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);

        public function LeavePetYard(_arg_1:GameSprite)
        {
            this.gameSprite = _arg_1;
            super("LeavePetYardDialog.title", "LeavePetYardDialog.text", TextKey.PET_DIALOG_REMAIN, TextKey.PET_DIALOG_LEAVE, null);
            addEventListener(Dialog.LEFT_BUTTON, this.onClose);
            addEventListener(Dialog.RIGHT_BUTTON, this.onExitToNexus);
            titleText_.setMultiLine(true);
        }

        private function onClose(_arg_1:Event):void
        {
            this.closeDialogSignal.dispatch();
        }

        private function onExitToNexus(_arg_1:Event):void
        {
            this.gameSprite.gsc_.escape();
            this.closeDialogSignal.dispatch();
        }


    }
}//package kabam.rotmg.pets.view.dialogs

