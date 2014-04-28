import sys, os
from PyQt4 import QtGui, QtCore

class Dialog(QtGui.QDialog):
    def __init__(self, path):
        QtGui.QDialog.__init__(self)
        self.viewer = QtGui.QLabel(self)
        self.viewer.setMinimumSize(QtCore.QSize(400, 400))
        self.viewer.setScaledContents(True)
        self.viewer.setPixmap(QtGui.QPixmap(path))
        self.editor = QtGui.QLineEdit(self)
        self.editor.returnPressed.connect(self.handleReturnPressed)
        layout = QtGui.QVBoxLayout(self)
        layout.addWidget(self.viewer)
        layout.addWidget(self.editor)

    def handleReturnPressed(self):
        if self.editor.text().simplified().isEmpty():
            self.reject()
        else:
            self.accept()

if __name__ == '__main__':

    app = QtGui.QApplication(sys.argv)
    args = app.arguments()[1:]
    if len(args) == 1:
        dialog = Dialog(args[0])
        if dialog.exec_() == QtGui.QDialog.Accepted:
            print dialog.editor.text().simplified().toLocal8Bit().data()
            sys.exit(0)
    else:
        print 'ERROR: wrong number of arguments'
    sys.exit(1)