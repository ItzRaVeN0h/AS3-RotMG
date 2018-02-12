﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.shop.ShopPopupMediator

package io.decagames.rotmg.shop
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.mysterybox.services.MysteryBoxModel;
    import kabam.rotmg.packages.services.PackageModel;
    import kabam.rotmg.game.model.GameModel;
    import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
    import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.gird.UIGrid;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import io.decagames.rotmg.ui.tabs.UITabs;
    import io.decagames.rotmg.ui.tabs.TabButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.tabs.UITab;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import kabam.rotmg.packages.model.PackageInfo;
    import __AS3__.vec.Vector;
    import io.decagames.rotmg.shop.packages.PackageBoxTile;
    import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
    import io.decagames.rotmg.shop.mysteryBox.MysteryBoxTile;
    import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
    import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
    import io.decagames.rotmg.ui.popups.header.PopupHeader;
    import com.company.assembleegameclient.parameters.Parameters;
    import io.decagames.rotmg.ui.buttons.BaseButton;

    public class ShopPopupMediator extends Mediator 
    {

        [Inject]
        public var view:ShopPopupView;
        [Inject]
        public var mysteryBoxModel:MysteryBoxModel;
        [Inject]
        public var packageBoxModel:PackageModel;
        [Inject]
        public var gameModel:GameModel;
        [Inject]
        public var openMoneyWindow:OpenMoneyWindowSignal;
        [Inject]
        public var closePopupSignal:ClosePopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        private var closeButton:SliceScalingButton;
        private var addButton:SliceScalingButton;
        private var mysteryBoxesGrid:UIGrid;
        private var packageBoxesGrid:UIGrid;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;
        private var tabs:UITabs;
        private var packageTab:TabButton;


        private function addEmptyTab(_arg_1:String):UITab
        {
            var _local_3:SliceScalingBitmap;
            var _local_4:Sprite;
            var _local_2:UITab = new UITab(_arg_1);
            _local_3 = TextureParser.instance.getSliceScalingBitmap("UI", "empty_shop");
            _local_4 = new Sprite();
            _local_4.addChild(_local_3);
            _local_3.x = 10;
            _local_3.y = -2;
            var _local_5:UILabel = new UILabel();
            _local_5.multiline = true;
            DefaultLabelFormat.backLaterLabel(_local_5);
            _local_5.text = "Oh, there are currently no Packages.\nPlease come back later!";
            _local_5.y = 155;
            _local_5.x = 170;
            _local_2.addContent(_local_4);
            _local_2.addChild(_local_5);
            return (_local_2);
        }

        private function createPackageBoxTab():UITab
        {
            var _local_2:PackageInfo;
            var _local_3:UITab;
            this.packageBoxesGrid = new UIGrid(550, 2, 11);
            this.packageBoxesGrid.x = 15;
            var _local_1:Vector.<PackageInfo> = this.packageBoxModel.getBoxesForGrid();
            for each (_local_2 in _local_1)
            {
                if (((!(_local_2 == null)) && ((!(_local_2.endTime)) || (_local_2.getSecondsToEnd() > 0))))
                {
                    this.packageBoxesGrid.addGridElement(this.createBoxTile(_local_2, PackageBoxTile));
                };
            };
            this.packageBoxesGrid.addDecoration("tabs_tile_decor");
            _local_3 = new UITab("Packages");
            _local_3.addContent(this.packageBoxesGrid);
            return (_local_3);
        }

        private function createMysteryBoxTab():UITab
        {
            var _local_2:MysteryBoxInfo;
            var _local_3:UITab;
            this.mysteryBoxesGrid = new UIGrid(550, 3, 11);
            this.mysteryBoxesGrid.x = 15;
            var _local_1:Vector.<MysteryBoxInfo> = this.mysteryBoxModel.getBoxesForGrid();
            for each (_local_2 in _local_1)
            {
                if (((!(_local_2 == null)) && ((!(_local_2.endTime)) || (_local_2.getSecondsToEnd() > 0))))
                {
                    this.mysteryBoxesGrid.addGridElement(this.createBoxTile(_local_2, MysteryBoxTile));
                };
            };
            this.mysteryBoxesGrid.addDecoration("tabs_tile_decor");
            _local_3 = new UITab("Mystery Boxes");
            _local_3.addContent(this.mysteryBoxesGrid);
            return (_local_3);
        }

        private function createBoxTile(_arg_1:GenericBoxInfo, _arg_2:Class):GenericBoxTile
        {
            var _local_5:String;
            var _local_3:GenericBoxTile = new _arg_2(_arg_1);
            var _local_4:Array = _arg_1.tags.split(",");
            for each (_local_5 in _local_4)
            {
                switch (_local_5)
                {
                    case "best_seller":
                        _local_3.addTag(new ShopBoxTag(ShopBoxTag.GREEN_TAG, "BEST"));
                        break;
                    case "hot":
                        _local_3.addTag(new ShopBoxTag(ShopBoxTag.ORANGE_TAG, "HOT"));
                        break;
                };
            };
            if (_arg_1.isOnSale())
            {
                _local_3.addTag(new ShopBoxTag(ShopBoxTag.RED_TAG, (this.calculateBoxPromotionPercent(_arg_1) + "% OFF")));
            };
            if (_arg_1.unitsLeft != -1)
            {
                _local_3.addTag(new ShopBoxTag(ShopBoxTag.PURPLE_TAG, (_arg_1.unitsLeft + " LEFT!")));
            };
            return (_local_3);
        }

        private function calculateBoxPromotionPercent(_arg_1:GenericBoxInfo):int
        {
            return (((_arg_1.priceAmount - _arg_1.saleAmount) / _arg_1.priceAmount) * 100);
        }

        override public function initialize():void
        {
            var _local_4:PackageInfo;
            this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "close_button"));
            this.addButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "add_button"));
            this.tabs = new UITabs(580);
            this.tabs.addTab(this.createMysteryBoxTab(), true);
            this.tabs.addTab(this.createPackageBoxTab());
            this.tabs.y = 115;
            this.tabs.x = 11;
            this.view.header.setTitle("Shop", 319, DefaultLabelFormat.defaultPopupTitle);
            this.view.header.showCoins(132).coinsAmount = this.gameModel.player.credits_;
            this.view.header.showFame(132).fameAmount = this.gameModel.player.fame_;
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.header.addButton(this.closeButton, PopupHeader.RIGHT_BUTTON);
            this.addButton.clickSignal.add(this.onAdd);
            this.view.header.addButton(this.addButton, PopupHeader.LEFT_BUTTON);
            this.view.addChild(this.tabs);
            var _local_1:Vector.<PackageInfo> = this.packageBoxModel.getBoxesForGrid();
            var _local_2:Date = new Date();
            _local_2.setTime(Parameters.data_["packages_indicator"]);
            var _local_3:Boolean;
            for each (_local_4 in _local_1)
            {
                if (((!(_local_4 == null)) && ((!(_local_4.endTime)) || (_local_4.getSecondsToEnd() > 0))))
                {
                    if (((_local_4.isNew()) && ((_local_4.startTime.getTime() > _local_2.getTime()) || (!(Parameters.data_["packages_indicator"])))))
                    {
                        _local_3 = true;
                    };
                };
            };
            this.packageTab = this.tabs.getTabButtonByLabel("Packages");
            if (this.packageTab)
            {
                this.packageTab.showIndicator = _local_3;
                this.packageTab.clickSignal.add(this.onPackageClick);
            };
            this.gameModel.player.creditsWereChanged.add(this.refreshCoins);
            this.gameModel.player.fameWasChanged.add(this.refreshFame);
            this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, "Buy Gold", "Click to buy more Realm Gold!", 200);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.addButton);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
        }

        private function onPackageClick(_arg_1:BaseButton):void
        {
            if (TabButton(_arg_1).hasIndicator)
            {
                Parameters.data_["packages_indicator"] = new Date().getTime();
                TabButton(_arg_1).showIndicator = false;
            };
        }

        override public function destroy():void
        {
            this.view.dispose();
            this.closeButton.dispose();
            this.addButton.dispose();
            this.gameModel.player.creditsWereChanged.remove(this.refreshCoins);
            this.gameModel.player.fameWasChanged.remove(this.refreshFame);
            this.tabs.dispose();
            this.mysteryBoxesGrid.dispose();
            this.packageBoxesGrid.dispose();
            this.toolTip = null;
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
            if (this.packageTab)
            {
                this.packageTab.clickSignal.remove(this.onPackageClick);
            };
        }

        private function refreshCoins():void
        {
            this.view.header.showCoins(132).coinsAmount = this.gameModel.player.credits_;
        }

        private function refreshFame():void
        {
            this.view.header.showFame(132).fameAmount = this.gameModel.player.fame_;
        }

        private function onAdd(_arg_1:BaseButton):void
        {
            this.openMoneyWindow.dispatch();
        }

        private function onClose(_arg_1:BaseButton):void
        {
            this.closePopupSignal.dispatch(this.view);
        }


    }
}//package io.decagames.rotmg.shop

