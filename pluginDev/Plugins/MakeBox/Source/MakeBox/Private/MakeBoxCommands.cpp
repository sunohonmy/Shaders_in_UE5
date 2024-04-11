// Copyright Epic Games, Inc. All Rights Reserved.

#include "MakeBoxCommands.h"

#define LOCTEXT_NAMESPACE "FMakeBoxModule"

void FMakeBoxCommands::RegisterCommands()
{
	UI_COMMAND(PluginAction, "MakeBox", "Execute MakeBox action", EUserInterfaceActionType::Button, FInputChord());
}

#undef LOCTEXT_NAMESPACE
