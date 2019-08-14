/**
  扩展一个看板模块
**/
layui.define(function (exports) {
    function KanbanColumn(name) {
        var self = this;

        this.name = name;
        this.element = createColumnElement();

        function createColumnElement() {
            var columnElement = $('<div class="kanban-column"></div>');
            var columnTitleElement = $('<h2 class="kanban-column-title">' + self.name + '</h2>');
            var columnListElement = $('<ul class="kanban-column-list"></ul>');

            columnElement.append(columnTitleElement)
                .append(columnListElement);
            return columnElement;
        }
    }
    KanbanColumn.prototype = {
        addCard: function (cardName, cardId, cardcolor, lastUpdateDate, memberImage, memberId, imageAction,
            taskClickAction, taskPriority) {
            var card = new KanbanCard(cardName, cardId, cardcolor, lastUpdateDate, memberImage, memberId
                , imageAction, taskClickAction, taskPriority);
            this.element.children('ul').append(card.element);
            return this;
        },
        removeColumn: function () {
            this.element.remove();
        }
    };

    function KanbanCard(taskName, taskId, color, lastUpdateDate, memberImage, memberId, imageAction,
        taskClickAction, taskPriority) {
        var self = this;

        this.taskName = taskName;
        this.taskId = taskId;
        this.lastUpdateDate = lastUpdateDate;
        this.color = color || 'white';
        this.memberImage = memberImage;
        this.memberId = memberId;
        this.element = createCardElement();

        function createCardElement() {
            var kanbanCard = $('<li class=kanban-card></li>');
            var kanbanCardImage = $('<img class="kanban-card-image">');
            kanbanCardImage.attr({ "src": self.memberImage, "data-memberId": self.memberId, "style": "cursor:pointer" });
            var kanbanIcon = $('<div style="justify-content: center;display: flex;"></div>')
            for (var i = 0; i < taskPriority; i++) {
                kanbanIcon.append($('<image src="/images/Home/fire.png" style="width:16px;height:16px;"></image>'));
            }

            var kanbanCardDescription = $('<div class="kanban-card-description"></div>');
            kanbanCardDescription.attr({ "data-taskId": self.taskId });
            var kanbanCardDate = $('<i class="kanban-card-date"></i>');

            kanbanCard.addClass('kanban-card-' + self.color);
            kanbanCardImage.click(function () {
                var memberId = $(this).attr("data-memberId");
                imageAction(memberId);
            });
            kanbanCardDescription.click(function () {
                var taskId = $(this).attr("data-taskId");
                taskClickAction(taskId);
            });
            kanbanCard.append(kanbanCardImage);
            kanbanCard.append(kanbanIcon);
            kanbanCardDescription.text(self.taskName);
            kanbanCardDate.text(self.lastUpdateDate);
            kanbanCard.append(kanbanCardDescription);
            kanbanCard.append(kanbanCardDate);
            return kanbanCard;
        }
    }
    KanbanCard.prototype = {
        removeCard: function () {
            this.element.remove();
        }
    };

    var mykanban = {
        name: 'Kanban',
        addColumn: function (columnName) {
            var column = new KanbanColumn(columnName);
            this.element.append(column.element);
            return column;
        },
        addOrientationIcon: function () {
            var icon = $('<div style="padding-top:15px"><i class="layui-icon layui-icon-triangle-r"></i></div>');
            this.element.append(icon);
        },
        init: function (kb) { this.element = kb; },
        element: null
    };

    //输出接口
    exports('mykanban', mykanban);
});