﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.signal.QuestRedeemCompleteSignal

package io.decagames.rotmg.dailyQuests.signal
{
    import org.osflash.signals.Signal;
    import kabam.rotmg.messaging.impl.incoming.QuestRedeemResponse;

    public class QuestRedeemCompleteSignal extends Signal 
    {

        public function QuestRedeemCompleteSignal()
        {
            super(QuestRedeemResponse);
        }

    }
}//package io.decagames.rotmg.dailyQuests.signal

