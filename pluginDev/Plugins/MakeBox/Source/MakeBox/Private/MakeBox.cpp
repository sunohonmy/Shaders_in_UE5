// Copyright Epic Games, Inc. All Rights Reserved.

#include "MakeBox.h"
#include "MakeBoxStyle.h"
#include "MakeBoxCommands.h"
#include "Misc/MessageDialog.h"
#include "ToolMenus.h"
#include "Editor/UnrealEd/Classes/Editor/EditorEngine.h"
#include "Engine/World.h"
#include "Engine/StaticMesh.h"
#include "Components/StaticMeshComponent.h"
#include "GameFramework/Actor.h"

static const FName MakeBoxTabName("MakeBox");

#define LOCTEXT_NAMESPACE "FMakeBoxModule"

void FMakeBoxModule::StartupModule()
{
	// This code will execute after your module is loaded into memory; the exact timing is specified in the .uplugin file per-module
	
	FMakeBoxStyle::Initialize();
	FMakeBoxStyle::ReloadTextures();

	FMakeBoxCommands::Register();
	
	PluginCommands = MakeShareable(new FUICommandList);

	PluginCommands->MapAction(
		FMakeBoxCommands::Get().PluginAction,
		FExecuteAction::CreateRaw(this, &FMakeBoxModule::PluginButtonClicked),
		FCanExecuteAction());

	UToolMenus::RegisterStartupCallback(FSimpleMulticastDelegate::FDelegate::CreateRaw(this, &FMakeBoxModule::RegisterMenus));
}

void FMakeBoxModule::ShutdownModule()
{
	// This function may be called during shutdown to clean up your module.  For modules that support dynamic reloading,
	// we call this function before unloading the module.

	UToolMenus::UnRegisterStartupCallback(this);

	UToolMenus::UnregisterOwner(this);

	FMakeBoxStyle::Shutdown();

	FMakeBoxCommands::Unregister();
}

void FMakeBoxModule::PluginButtonClicked()
{
	//Get current world context
    UWorld* World = GEditor->GetEditorWorldContext().World();
    if (!World) return;

    //Define spawn params
    FActorSpawnParameters SpawnParameters;
    SpawnParameters.Name = TEXT("SpawnedBoxMesh");
    SpawnParameters.SpawnCollisionHandlingOverride = ESpawnActorCollisionHandlingMethod::AlwaysSpawn;

    //Define location and rotation
    FVector Location(0.0f, 0.0f, 0.0f);
    FRotator Rotation(0.0f, 0.0f, 0.0f);

    //Spawn actor
    AActor* SpawnedActor = World->SpawnActor<AActor>();
    if (!SpawnedActor) return;
	//if(SpawnedActor->GetName())

    //Add a StaticMeshComponent to the spawned actor
    UStaticMeshComponent* MeshComponent = NewObject<UStaticMeshComponent>(SpawnedActor);
    if (!MeshComponent) return;

    //Set static mesh
    UStaticMesh* BoxMesh = LoadObject<UStaticMesh>(nullptr, TEXT("/Engine/BasicShapes/Cube.Cube"));
    if (!BoxMesh) return;
    MeshComponent->SetStaticMesh(BoxMesh);

    //Attatch component and register component
    MeshComponent->AttachToComponent(SpawnedActor->GetRootComponent(), FAttachmentTransformRules::KeepWorldTransform);
    MeshComponent->RegisterComponent();

    //Select actor when spawned
	//SpawnedActor->IsSelected();
	
    GEditor->SelectNone(false, true);
    GEditor->SelectActor(SpawnedActor, true, true, true, true);
	///Script/Engine.StaticMesh'/Engine/BasicShapes/Cube.Cube'

}

void FMakeBoxModule::RegisterMenus()
{
	// Owner will be used for cleanup in call to UToolMenus::UnregisterOwner
	FToolMenuOwnerScoped OwnerScoped(this);

	{
		UToolMenu* Menu = UToolMenus::Get()->ExtendMenu("LevelEditor.MainMenu.Window");
		{
			FToolMenuSection& Section = Menu->FindOrAddSection("WindowLayout");
			Section.AddMenuEntryWithCommandList(FMakeBoxCommands::Get().PluginAction, PluginCommands);
		}
	}

	{
		UToolMenu* ToolbarMenu = UToolMenus::Get()->ExtendMenu("LevelEditor.LevelEditorToolBar.PlayToolBar");
		{
			FToolMenuSection& Section = ToolbarMenu->FindOrAddSection("PluginTools");
			{
				FToolMenuEntry& Entry = Section.AddEntry(FToolMenuEntry::InitToolBarButton(FMakeBoxCommands::Get().PluginAction));
				Entry.SetCommandList(PluginCommands);
			}
		}
	}
}

#undef LOCTEXT_NAMESPACE
	
IMPLEMENT_MODULE(FMakeBoxModule, MakeBox)