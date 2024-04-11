// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "Framework/Commands/Commands.h"
#include "MakeBoxStyle.h"

class FMakeBoxCommands : public TCommands<FMakeBoxCommands>
{
public:

	FMakeBoxCommands()
		: TCommands<FMakeBoxCommands>(TEXT("MakeBox"), NSLOCTEXT("Contexts", "MakeBox", "MakeBox Plugin"), NAME_None, FMakeBoxStyle::GetStyleSetName())
	{
	}

	// TCommands<> interface
	virtual void RegisterCommands() override;

public:
	TSharedPtr< FUICommandInfo > PluginAction;
};
