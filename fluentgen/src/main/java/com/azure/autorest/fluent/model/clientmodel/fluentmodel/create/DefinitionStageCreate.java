/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 */

package com.azure.autorest.fluent.model.clientmodel.fluentmodel.create;

import com.azure.autorest.fluent.model.clientmodel.fluentmodel.method.FluentMethod;

import java.util.ArrayList;
import java.util.List;

public class DefinitionStageCreate extends DefinitionStage {

    private FluentMethod createMethod;
    private FluentMethod createMethodWithContext;

    public DefinitionStageCreate() {
        super("WithCreate");
    }

    @Override
    public String getDescription(String modelName) {
        return String.format("The stage of the %1$s definition which contains all the minimum required properties for the resource to be created, but also allows for any other optional properties to be specified.", modelName);
    }
}
