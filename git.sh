#!/bin/bash

read -p "¿Quieres añadir y confirmar tus cambios locales? (s/n): " confirm_local_changes
if [[ "$confirm_local_changes" == "s" || "$confirm_local_changes" == "S" ]]; then
    git add .

    read -p "Describe brevemente los cambios realizados: " commit_message
    git commit -m "$commit_message"
    echo "Cambios locales añadidos y confirmados."
else
    echo "No se añadieron cambios locales."
fi

# Paso 2: Hacer pull para fusionar cambios remotos
echo "Haciendo git pull para actualizar cambios del repositorio remoto..."
git pull --rebase

# Paso 3: Confirmar cambios resultantes después del pull
echo "Mostrando estado después del pull..."
git status
read -p "¿Quieres confirmar los cambios después de la fusión? (s/n): " confirm_after_pull
if [[ "$confirm_after_pull" == "s" || "$confirm_after_pull" == "S" ]]; then
    git add .
    read -p "Describe los cambios resultantes de la fusión (si aplica): " merge_message
    git commit -m "$merge_message"
fi

# Paso 4: Hacer push para subir los cambios al repositorio remoto
read -p "¿Quieres hacer git push para subir los cambios al repositorio remoto? (s/n): " confirm_push
if [[ "$confirm_push" == "s" || "$confirm_push" == "S" ]]; then
    echo "Haciendo git push..."
    git push
else
    echo "No se subieron los cambios al repositorio remoto."
fi

echo "Script finalizado."
