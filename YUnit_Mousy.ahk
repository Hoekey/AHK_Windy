﻿#NoEnv
#SingleInstance force

#Include %A_ScriptDir%\Yunit\Yunit.ahk
#Include %A_ScriptDir%\Yunit\Window.ahk
#Include %A_ScriptDir%\Yunit\StdOut.ahk
#include <Windy\Mousy>
#include <Windy\Pointy>

#Warn All
#Warn LocalSameAsGlobal, Off


debug := 1
ReferenceVersion := "1.1.4"

;Yunit.Use(YunitStdOut, YunitWindow).Test(TempTestSuite)
Yunit.Use(YunitStdOut, YunitWindow).Test(_BaseTestSuite, MiscTestSuite)
Return

class TempTestSuite
{
	Begin()  {
		Global debug
		this.r := new Mousy(debug)
    }

    move() {
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		this.r.x := 100
		this.r.y := 100
		this.r.movespeed := 25
		this.r.movemode := 1
		this.r.x :=1000
		this.r.movemode := 3
		this.r.pos := new Pointy(500,500)
		this.r.movemode := 2
		this.r.pos := new Pointy(100,100)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
    }
		
	
	End() {
        this.remove("r")
		this.r := 
    }

}


class MiscTestSuite
{
	Begin()  {
		Global debug
		this.r := new Mousy(debug)
    }
		
	Locate() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		this.r.locate()
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	monitorID() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		this.r.monitorID := 1
		Yunit.assert(this.r.monitorID == 1)
		this.r.monitorID := 2
		Yunit.assert(this.r.monitorID == 2)

		this.r.x := 100
		this.r.y := 100
		Yunit.assert(this.r.monitorID == 1)
		this.r.x := 2500
		Yunit.assert(this.r.monitorID == 2)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
	}

	speed() {
    	OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		this.r.speed := 10
		saveSpeed := this.r.speed
		Yunit.assert(this.r.speed == 10)
		this.r.speed := 1
		Yunit.assert(this.r.speed == 1)
		this.r.speed := 20
		Yunit.assert(this.r.speed == 20)
		this.r.speed := saveSpeed
		Yunit.assert(this.r.speed == saveSpeed)
    	OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    }

        move() {
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		this.r.x := 100
		this.r.y := 100
		this.r.movespeed := 25
		this.r.movemode := 1
		this.r.x :=1000
		this.r.movemode := 3
		this.r.pos := new Pointy(500,500)
		this.r.movemode := 2
		this.r.pos := new Pointy(100,100)
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
    }

	End() {
        this.remove("r")
		this.r := 
    }
}

; Does not work within YUnit-TestSuite :-(
class ProblematicTestSuite
{
	Begin()  {
		Global debug
		this.r := new Mousy(debug)
    }

    confine() {
    	; This UnitTest fails due to failure with YUnit
    	OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
    	this.r.confine := false
    	this.r.pos(1,1)
    	pos := this.r.pos 
    	OutputDebug % pos.Dump()
        this.r.confineRect := new Recty(100,100,100,100)
    	this.r.confine := true
    	this.r.pos(1,1)
    	pos := this.r.pos 
    	OutputDebug % pos.Dump()
    	this.r.confine := false
    	OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
    }

     trail() {
		CoordMode,Mouse,Screen
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		MouseMove, 1,1,10
		savetrail := this.r.trail
		this.r.trail := 7
		MouseMove, 1000, 1000,10
		Yunit.assert(this.r.trail == 7)
		this.r.trail := 1
		MouseMove, 1,1,10
		Yunit.assert(this.r.trail == 1)
		this.r.trail := savetrail
		OutputDebug % "<<<<<[" A_ThisFunc "]<<<<<"
    }
		
	End() {
        this.remove("r")
		this.r := 
    }

}


class _BaseTestSuite {
    Begin() {
	}
	
	Version() {
		Global debug
		OutputDebug % ">>>>>[" A_ThisFunc "]>>>>>"
		Global ReferenceVersion
		obj := new Mousy(debug)
		OutputDebug % "Mousy Version <" obj.version "> <-> Required <" ReferenceVersion ">"
		Yunit.assert(obj.version == ReferenceVersion)
		OutputDebug % ">>>>[" A_ThisFunc "]>>>>"
	}

	End() {
	}
}
