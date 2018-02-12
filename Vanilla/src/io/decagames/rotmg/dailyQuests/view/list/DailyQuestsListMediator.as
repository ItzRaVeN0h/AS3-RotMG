﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.list.DailyQuestsListMediator

package io.decagames.rotmg.dailyQuests.view.list
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
    import kabam.rotmg.ui.model.HUDModel;
    import io.decagames.rotmg.dailyQuests.model.DailyQuest;
    import __AS3__.vec.Vector;
    import kabam.rotmg.constants.GeneralConstants;
    import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
    import __AS3__.vec.*;

    public class DailyQuestsListMediator extends Mediator 
    {

        [Inject]
        public var view:DailyQuestsList;
        [Inject]
        public var model:DailyQuestsModel;
        [Inject]
        public var hud:HUDModel;


        override public function initialize():void
        {
            var _local_4:DailyQuest;
            var _local_5:DailyQuestListElement;
            var _local_1:Vector.<DailyQuest> = this.model.questsList;
            var _local_2:Boolean = true;
            var _local_3:Vector.<int> = ((this.hud.gameSprite.map.player_) ? this.hud.gameSprite.map.player_.equipment_.slice((GeneralConstants.NUM_EQUIPMENT_SLOTS - 1), (GeneralConstants.NUM_EQUIPMENT_SLOTS + (GeneralConstants.NUM_INVENTORY_SLOTS * 2))) : new Vector.<int>());
            for each (_local_4 in _local_1)
            {
                _local_5 = new DailyQuestListElement(_local_4.id, _local_4.name, _local_4.completed, DailyQuestInfo.hasAllItems(_local_4.requirements, _local_3), _local_4.category);
                if (_local_2)
                {
                    _local_5.isSelected = true;
                };
                _local_2 = false;
                this.view.addQuestToList(_local_5);
            };
            this.view.scrollBar.update();
        }

        override public function destroy():void
        {
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.list
