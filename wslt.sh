#!/bin/bash
#WSL Tools
wsltVersion="v0.0.0.1"

#CONFIG
wsltConfig(){
    #UPDATE
    echo "$wsltCheckUpdate..."
    curl -o ~/.wsltUpdate https://raw.githubusercontent.com/DeicPro/WSLT/master/update.txt >/dev/null 2>&1
    . ~/.wsltUpdate
    if [ ! "$wsltLastVersion" == "$wsltVersion" ]; then
        echo "$wsltNewVersion: $wsltLastVersion. $wsltUpdating..."
        curl -o ~/.wslt $wsltDownloadUrl >/dev/null 2>&1
        cp -f ~/.wslt /bin/wslt
        echo "$wsltUpdated. $wsltRunThisWith \\e[35mwslt\\e[0m $wsltNow."
        exit
    fi
    echo "$wsltNoUpdate."
    
    #INSTALL
    if [ ! -f /bin/wslt ]; then
        echo "$wsltInstalling wslt..."
        cp -f $(dirname $0)/$(basename $0) /bin/wslt
        echo -e "$wsltInstalled. $wsltRunThisWith \\e[35mwslt\\e[0m $wsltNow."
        exit
    fi
    . ~/.wsltConf

    #LANGUAGES
    #default
    wsltCheckUpdates="Checking for update"
    wsltVersionFound="New version found"
    wsltUpdating="Updating"
    wsltUpdated="Updated"
    wsltRunThisWith"Run this program with"
    wsltNow="Now"
    wsltNoUpdate="You have the lastest version already"
    wsltInstalling="Installing"
    wsltInstalled="Installed"
    wsltMainTittle="Windows Subsystem for Linux's Tools"
    wsltTweaksTittle="Tweaks"
    wsltDETittle="Desktop Environments"
    wsltSettingsTittle="Setting WSL Tools"
    wsltExit="Exit"
    wsltSelectOption="Select an option"
    wsltPointerPosition="\\e[7;19H" #Pointer position of $wsltSelectOption variable
    wsltLanguageTittle="Language"
    wsltUninstall="Uninstall WSL Tools"
    wsltBack="Back"
    wsltInvalidOption="Invalid option. Press a valid option + ENTER key"
    wsltWantInstall="Do you want to download & install" #?
    wsltOptional="Optional"
    wsltYes="Yes"
    wsltNo="No"
    wsltUninstallWSLT="Uninstalling wslt"
    wsltUninstalled="Uninstalled"
    #esES
    if [ "$wsltLanguage" == esES ]; then
        wsltCheckUpdates="Buscando actualización"
        wsltVersionFound="Nueva versión encontrada"
        wsltUpdating="Actualizando"
        wsltUpdated="Actualizado"
        wsltRunThisWith"Ejecuta este programa con"
        wsltNow="Ahora"
        wsltNoUpdate="Tienes la versión más reciente"
        wsltInstalling="Instalando"
        wsltInstalled="Instalado"
        wsltMainTittle="Herramientas de subsistema Windows para Linux"
        wsltTweaksTittle="Ajustes"
        wsltDETittle="Entornos de escritorio"
        wsltSettingsTittle="Configurar herramientas de WSL"
        wsltExit="Salir"
        wsltSelectOption="Seleccionar una opción"
        wsltPointerPosition="\\e[7;25H"
        wsltLanguageTittle="Idioma"
        wsltUninstall="Desinstalar herramientas de WSL"
        wsltBack="Atrás"
        wsltInvalidOption="Opción invalida. Presiona una opción valida + tecla ENTER"
        wsltWantInstall="¿Quieres descargar e instalar"
        wsltOptional="Opcional"
        wsltYes="Si"
        WsltNo="No"
        wsltUninstallWSLT="Desinstalando wslt"
        wsltUninstalled="Desinstalado"
    fi
    wsltMainMenu
}

#MAIN
wsltMainMenu(){
    while clear; do
        echo -e " \\e[35m~$wsltMainTittle\\e[0m"
        echo "  [1] $wsltTweaksTittle"
        echo "  [2] $wsltDETittle"
        echo "  [3] $wsltSettingsTittle"
        echo ""
        echo "  [E] $wsltExit"
        echo "$wsltSelectOption: "
        if [ "$wsltInvalidOptionTrue" == 1 ]; then
            echo "$wsltInvalidOption."
            wsltInvalidOptionTrue=0
        fi
        echo -e -n "$wsltPointerPosition"
        read i
        case $i in
            1)
                wsltTweaksMenu
            ;;
            2)
                wsltDEMenu
            ;;
            3)
                wsltSettingsMenu
            ;;
            e|E)
                exit
            ;;
            *)
                wsltInvalidOptionTrue=1
            ;;
        esac
    done
}
wsltTweaksMenu(){
    if [ ! "$(grep "export DISPLAY=:0.0" ~/.bashrc)" ]; then
    echo "export DISPLAY=:0.0" >> ~/.bashrc
    elif [ ! "$(grep "<listen>tcp:host=localhost,port=0</listen>" /etc/dbus-1/session.conf)" ]; then
    sed -i 's$<listen>.*</listen>$<listen>tcp:host=localhost,port=0</listen>$' /etc/dbus-1/session.conf
    fi
}
wsltDEMenu(){
    echo " $wsltWantInstall compizconfig-settings-manager? ($wsltOptional)"
    echo "  [1] $wsltYes"
    echo "  [2] $wsltNo"
    read i
    case $i in
    1)
    wsltCCSM="compizconfig-settings-manager"
    ;;
    *)
    :
    ;;
    esac
    apt-get -y install ubuntu-desktop unity $wsltCCSM
}
wsltSettingsMenu(){
    while :; do
        echo -e " \\e[35m~$wsltSettingsTittle\\e[0m"
        echo "  [1] $wsltLanguageTittle"
        echo "  [2] $wsltUninstall"
        echo ""
        echo "  [B] $wsltBack"
        echo ""
        echo "  [E] $wsltExit"
        echo -n "$wsltSelectOption: "
        read i
        case $i in
            1)
                wsltLanguageMenu
            ;;
            2)
                echo "$wsltUninstallWSLT..."
                rm -f /bin/wslt
                rm -f ~/.wsltConf
                echo "$wsltUninstalled."
                exit
            ;;
            b|B)
                break
            ;;
            e|E)
                exit
            ;;
            *)
                echo "$wsltInvalidOption."
            ;;
        esac
    done
}
wsltLanguageMenu(){
    while :; do
        echo -e " \\e[35m~$wsltLanguageTittle\\e[0m"
        #echo "  [*] Language"
        echo "  [1] English"
        echo "  [2] Español"
        if [ -f ~/.wsltConf ]; then
            echo ""
            echo "  [B] $wsltBack"
            echo ""
            echo "  [E] $wsltExit"
        fi
        echo -n "$wsltSelectOption: "
        read i
        case $i in
            #*)
                #sed -i 's/wsltLanguage=.*/wsltLanguage=LANGUAGECODE/' ~/.wsltConf
                #wsltConfig
            #;;
            1)
                sed -i 's/wsltLanguage=.*/wsltLanguage=default/' ~/.wsltConf
                wsltConfig
            ;;
            2)
                sed -i 's/wsltLanguage=.*/wsltLanguage=esES/' ~/.wsltConf
                wsltConfig
            ;;
            b|B)
                if [ -f ~/.wsltConf ]; then
                    break
                fi
                echo "$wsltInvalidOption."
            ;;
            e|E)
                if [ -f ~/.wsltConf ]; then
                    exit
                fi
                echo "$wsltInvalidOption."
            ;;
            *)
                echo "$wsltInvalidOption."
            ;;
        esac
    done
}

#INITIAL
if [ ! -f ~/.wsltConf ]; then
    echo "wsltLanguage=default" >> ~/.wsltConf
    . ~/.wsltConf
    wsltLanguageMenu
fi
wsltConfig
